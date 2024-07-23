// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract attackReentrancy {
    
    Reentrancy public reentrancy;
    
    constructor(Reentrancy _reentrancy) {
        
        reentrancy = _reentrancy;
    }
    
    function retoken() public {
        
        reentrancy.token = 0xd9145CCE52D386f254917e481eB44e9943F39139;
    
        
    }
    
    function getToken(uint256 amount) external payable{
        
        reentrancy.deposit{value: 1 wei}();
        
        reentrancy.withdraw(amount);
    }
    
}