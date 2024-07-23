// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZhangPan{
    function getBalance(address add) public view returns(uint256){
        return add.balance;
    }
    function getBlockHash() public view returns(bytes32){
        return blockhash(block.number);
    }
    function getLastBlockHash() public view returns(bytes32){
        return blockhash(block.number-1);
    }
    function getTime() public view returns(uint256){
        return block.timestamp;
    }
    function getBlockHeight() public view returns(uint256){
        return block.number;
    }
    function getDifficulty() public view returns(uint256){
        return block.difficulty;
    }
    function getGasLimit() public view returns(uint){
       return  block.gaslimit;
    }
    function getCoinBase() public view returns(address){
        return block.coinbase;
    }
}