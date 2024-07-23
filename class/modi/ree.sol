//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.6.0;

interface IERC20like{
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external  returns (uint256);
}
contract reentrancy{
    address token = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    uint256 public score;
    uint256 public times =1;
    bytes32 public password;
    mapping(address => uint256)public depositTimes;
    struct User{
        bytes32 userID;
    }
    User[] public users;
    constructor()public{
        password = keccak256(abi.encodePacked(blockhash(block.number-1)));
    }
    function deposit(uint256 amount)public{
        depositTimes[msg.sender]+=1;
        require(IERC20like(token).balanceOf(msg.sender)>amount,"");
        IERC20like(token).transferFrom(msg.sender,address(this),amount);
        times+=1;
    }

    function withdraw(uint256 amount)public{
        require(depositTimes[msg.sender]>0);
        IERC20like(token).transfer(msg.sender,amount);
        depositTimes[msg.sender]-=amount;
        times-=1;
    }

    function addUser(bytes32 guess,bytes32 value)public {
        require(guess == password);
        User storage s;
        s.userID = value;
        users.push(s);
    }

    function isCompleted()public{
        if (token != 0xd9145CCE52D386f254917e481eB44e9943F39138){
            score+=25;
        }
        if(times==0){
            score+=75;
        }
    }
}
