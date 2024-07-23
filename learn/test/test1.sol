//SPDX-License-Identifier：MIT
pragma solidity ^0.8.4;
contract HelloWeb3{
    function a(uint16 x1,uint16 x2) external pure returns(uint16 output){
        output  = x1 ^ x2;
        return output;
    }
    function b() public pure returns(uint16 output){
        return a(1,2);
    }
}