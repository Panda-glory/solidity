// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract zhangpan {
    function getBalance1(address add) public view returns (uint256) {
        return add.balance;
    }

function getBalance2(address add) public view returns (uint256) {
      return add.balance;
}
//     function getBlockHash() public view returns(bytes32){
//         return blockhash(_number);
//     }
//     function getLastBlockHash() public view returns(bytes32){
//         return blockhash(_number - 1);
//     }
//     function getTimestamp() public view returns(uint){
//         return block.timestamp;
//     }
//     function getBlockH() public view returns(uint){
//         return block.number;
//     }
//     function getDifficulty() public view returns(uint){
//         return block.difficulty;
//     }
//     function getLimit() public view returns(uint){
//         return block.gaslimit;
//     }
//     function getCoinbase() public view returns(address){
//         return block.coinbase;
//     }
}
