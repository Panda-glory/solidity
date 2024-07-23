pragma solidity >=0.7.1 <0.9.0;
//函数调用 可发生在合约内部或外部，
// 且函数对其他合约有不同程度的可见性（ 可见性和 getter 函数）。
// 函数 可以接受 参数和返回值。
contract TinyAuctionfunction {
    uint x = 10 ;
    function Mybid() public payable { // 定义函数
        // ...
    }
}

// Helper function defined outside of a contract
//
function helper(uint x) pure returns (uint) {
    return x * 2 ;
}

//修改器
contract MyPurchase {
    address public seller;
    modifier onlySeller() {
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }
    function abort() public onlySeller {
        
    }
}
contract TinyAuctionEvent {
    event HighestBidIncreased(address bidder, uint amount); // 事件

    function bid() public payable {
        // ...
        emit HighestBidIncreased(msg.sender, msg.value); // 触发事件
    }
}
