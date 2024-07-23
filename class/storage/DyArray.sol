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
contract DynArray {
    uint public a = 1; // slot 0
    uint public b = 2; // slot 1
    uint[] c;
    constructor () {
        c.push(3);
        c.push(4);
    }
    function calSlot(uint slot) public pure returns(uint256 ret){
        return uint256(keccak256(abi.encodePacked(slot)));
    }
    function getStorageAt(uint slot) public view returns (bytes32 ret) {
        return Storage.getStorageAt(slot);
    }
    function setStorageAt(uint slot, uint data) public returns (bytes32 ret) {
        return Storage.setStorageAt(slot, data);
    }
    function getSlotNum() public returns(uint256 slota, uint256 slotb, uint256 slotc0,uint256 slotc1 ) {
        assembly{
            slota := a.slot
            slotb := b.slot
        }
    }
}
