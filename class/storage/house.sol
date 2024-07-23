// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract A {
    uint a = 1;//0
    uint128 b = 2;//1
    uint128 c = 3;//1
}
contract B {
    uint d = 4;//2
    uint e = 5;//3
}
contract C is A, B {
    struct S {
        uint128 a;
        uint128 b;
        uint[2] staticArray;
        uint[] dynArray;
    }
    uint x;
    uint8 y;
    uint16 z;
    uint[2] staticArray;
    uint128[] dynArray;
    S public s;
    address public addr;
    mapping (uint => mapping (address => bool)) public map;//14
    string public s1;
    bytes public b1;
    mapping(uint => bool) public map2;//17
    mapping(bytes => bool) public map3;//18
    bool public bo1;
    bool public bo2;
    bool public bo3;
    mapping(bytes4 => address) public map4;//20
    constructor(bytes memory b_) {
        x = 6;//4
        y = 7;//5
        z = 8;//5
        staticArray = [uint(9), uint(10)];//6，7
        dynArray = new uint128[](3);//8
        dynArray[0] = 11;//keccak256(8)+0
        dynArray[1] = 12;//keccak256(8)+1，因为是uint128，所以和上面在同一个slot
        dynArray[2] = 13;//keccak256(8)+2,因为是uint128，所以和上面不同在下一个slot
        s = S({
            a: 14,//9
            b: 15,//9
            staticArray: [uint(16), uint(17)],//10，11
            dynArray: new uint[](3)//12
        });
        s.dynArray[0] = 18;//keccak256(12)+0
        s.dynArray[1] = 19;//keccak256(12)+1
        s.dynArray[2] = 20;//keccak256(12)+2
        addr = msg.sender;//13
        map[0][msg.sender] = true;//keccak256(uint256(msg.sender).keccak256(uint256(14).uint256(0))
        map[3][msg.sender] = true;//keccak256(uint256(msg.sender).keccak256(uint256(14).uint256(3))
        s1 = "hello";//15，内容和长度
        b1 = b_;//16，内容和长度
        map2[0] = true;//keccak256(uint256(17).uint256(0))
        map2[4] = true;//keccak256(uint256(17).uint256(4))
        map3[b1] = true;//keccak256(uint256(18).uint256(b1))
        bo1 = true;//19
        bo2 = false;//19
        bo3 = true;//19
        map4[bytes4(0x6af479b2)] = msg.sender;//
    }
    function hashSlot(uint slot) public pure returns (bytes32) {
        return bytes32(keccak256(abi.encodePacked(slot)));
    }
    function getStorageAt(uint slot) public view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }
    function getArrayDataSlotGivenIndex(
        uint slot,
        uint index
    ) public pure returns (bytes32) {
        return bytes32(uint(keccak256(abi.encodePacked(slot))) + index);
    }
    function getMapLocation(uint slot, uint key) public pure returns (bytes32) {
        return bytes32(keccak256(abi.encode(key, slot)));
    }
    function getMapLocation2(uint slot, bytes memory key) public pure returns (bytes32) {   
        return bytes32(keccak256(abi.encodePacked(keccak256(key), slot)));
    }
    function abiEncode(uint slot, bytes4 key) public pure returns (bytes memory) {
        return abi.encode(key, slot);
    }
    function getMap4Location(uint slot, bytes4 key) public pure returns (bytes32) {
        return bytes32(keccak256(abi.encode(key, slot)));
    }
    // function getkeccak(uint slot) public pure returns (bytes32){
    //     return bytes32(keccak256(abi.encode(slot)));
    // }
}


