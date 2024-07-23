// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
library StringUtil{
    enum CompareResult { Equal , Less , Greater , Invalid}
    function compare(string memory str1, string memory str2) public pure returns(CompareResult){
        if (bytes(str1).length == 0){
            return CompareResult.Invalid;
        }else if (bytes(str2).length == 0){
            return CompareResult.Invalid;
        }else if (keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2))){
            return CompareResult.Equal;
        }else {
            uint a = bytes(str1).length;
            if ( a > bytes(str2).length){
                return CompareResult.Greater;
            } else if ( a < bytes(str2).length){
                return CompareResult.Less;
            }else{
                for (uint i = 0; i <a ;i++ ){
                     if (bytes(str1)[i] > bytes(str2)[i]){
                         return CompareResult.Greater;
                    }
                     if (bytes(str1)[i] < bytes(str2)[i]){
                         return CompareResult.Less;
                    }
                }
            }
        }
    }
}