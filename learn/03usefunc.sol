//SPDX-License-Identifier MIT
pragma solidity ^0.8.4;
contract usefunc{
    uint public number = 5;
    function add() external {
        number = number + 1;
    }
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number + 1;
    }
    function addView() external view returns (uint256 new_number){
        new_number = number + 1;
    }
    //internal：内部
    function minus() internal {
        number = number - 1;
    }
    //合约内的函数可以调用的内部函数
    function numusCall() external {
        minus();
    }
    function minusPayable() external payable returns(uint256 balance){
        minus();
        balance = address(this).balance;
    }
}