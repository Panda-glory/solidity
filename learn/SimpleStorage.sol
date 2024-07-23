//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage {
    //boolean,uint,int,address,bytes
    //This gets ininialized to zere!
    //全局变量所有函数都能访问
     uint256 public favoriteNumber;
     function store(uint256 _favoritaNmuber) public {
         favoriteNumber = _favoritaNmuber;
         uint256 testVar = 5;
     }
     //view pure只能访问
     function retrieve() public view returns(uint256){
         return favoriteNumber;
     }
     function add() public pure returns(uint256){
         return (1 + 1);
    
     }
}
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
