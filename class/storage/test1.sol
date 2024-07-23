// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import './UseStorage.sol';
contract A {
    uint a = 1; // slot 0 for contract D. slot 2 for contract E.
    uint128 b = 2; // slot 1 for contract D slot 3 for contract E.
    uint128 c = 3;
}
contract B {
    uint d = 4; // slot 2 for contract D. slot 0 for contract E.
    uint e = 5; // slot 3 for contract D. slot 1 for contract E.
}
contract C {
    function getStorageAt(uint slot) public view returns (bytes32 ret) {
        return Storage.getStorageAt(slot);
    }
    function setStorageAt(uint slot, uint data) public returns (bytes32 ret) {
        return Storage.setStorageAt(slot, data);
    }
}
contract D is A, B, C {
    uint f = 6; // slot 4
}
contract E is B, A , C{
    uint f = 6; // slot 4
}
