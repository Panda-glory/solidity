// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.7.6;

contract WETH9 {
    string public name = "Wrapped ETH";
    string public symbol = "WETH";
    uint8 public decimals = 18;

    event Approval(address indexed src, address indexed guy, uint256 wad);
    event Transfer(address indexed src, address indexed dst, uint256 wad);
    event Deposit(address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);
    event DepositTo(address indexed src, address indexed toAddress, uint256 amount);
    event WithdrawTo(address indexed src, address indexed toAddress, uint256 amount);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 wad) public {
        require(balanceOf[msg.sender] >= wad);
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    function approve(address guy, uint256 wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint256 wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(
        address src,
        address dst,
        uint256 wad
    ) public returns (bool) {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint256(-1)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);
        return true;
    }
    function depositTo(address _toAddress) public payable{
        balanceOf[_toAddress] += msg.value;
        emit DepositTo(msg.sender,_toAddress,msg.value);
    }
    function withdrawTo(address payable _toAddress, uint256 wad) public{
        require(balanceOf[_toAddress] >= wad);
        balanceOf[_toAddress] -= wad;
        _toAddress.transfer(wad);
        emit WithdrawTo(msg.sender,_toAddress,wad);
    }
    function withdrawFrom(address from,address payable to, uint256 value) public{
        require(balanceOf[from] >= value);
        require(allowance[from][msg.sender] >= value);
        allowance[from][msg.sender] -= value;
        balanceOf[from] -= value;
        to.transfer(value);
    }
}
