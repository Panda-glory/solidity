// SPDX-License-Identifier: MIT
pragma solidity >=0.8.16;
import './StringUtil.sol';
contract HelloWorld{
    function myFirstHelloWorld() virtual public pure returns (string memory){
        return "Hello World! My name is Zhang Pan.";
    }
}
contract HelloMyWorld is HelloWorld{
    function myFirstHelloWorld() virtual public pure override returns(string memory){
        string memory str1 = super.myFirstHelloWorld();
        string memory str2 = "Hello World! My name is Zhang San.";
        string memory str3 = " My class number is 201.";
        bytes memory b1 = bytes(str1);
        bytes memory b3 = bytes(str3);
        if (uint(StringUtil.compare(str1,str2)) != 0){
            return string(abi.encodePacked(str1," My class number is 201."));
        }else{
            return "It's not me!";
        }
    }
}