// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract DataStorage{
    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        // _x[0] = 0; //这样修改会报错
        return(_x);
    }
}