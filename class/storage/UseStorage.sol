// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
library Storage {
    function getStorageAt(uint slot) public view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }
    function setStorageAt(uint slot, uint data) public returns (bytes32 ret) {
        assembly {
            sstore(slot, data)
            ret := sload(slot)
        }
    }
}
contract UseStorage {
    uint public a = 1; // slot 0
    uint public b = 2; // slot 1
    uint immutable public c; // not stored at storage
    uint constant public d = 4; // not stored at storage
    string public e = "chengduxinxigongchengdaxue"; // slot 2（占用存储大小取决于数据长度）
    struct Info {
        uint128 f;
        uint128 g;
        uint256[2] h;
    }
    Info public i;
    constructor() {
        c = 3;
        i = Info({
            f: 5,// slot 3
            g: 6,// slot 3
            h: [uint(7), uint(8)]// slot 4-5
        });
    }
    function getStorageAt(uint slot) public view returns (bytes32 ret) {
        return Storage.getStorageAt(slot);
        }
    function setStorageAt(uint slot, uint data) public returns (bytes32 ret) {
        return Storage.setStorageAt(slot, data);
    }
}
