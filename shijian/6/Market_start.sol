// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./interfaces/IERC721Receiver.sol";
import "./tokens/ERC721.sol";
import "./tokens/ERC20.sol";
import "./utils/SafeMath.sol";

contract Market is IERC721Receiver {
    ERC20 public erc20;
    ERC721 public erc721;

    bytes4 internal constant MAGIC_ON_ERC721_RECEIVED = 0x150b7a02;

    struct Order {
        address seller;
        uint256 tokenId;
        uint256 price;
    }

    mapping(uint256 => Order) public orderOfId; // token id to order
    Order[] public orders;
    mapping(uint256 => uint256) public idToOrderIndex;
    mapping(uint256 => uint256) public indesOrderId;
    event Deal(address buyer, address seller, uint256 tokenId, uint256 price);
    event NewOrder(address seller, uint256 tokenId, uint256 price);
    event CancelOrder(address seller, uint256 tokenId);
    event ChangePrice(
        address seller,
        uint256 tokenId,
        uint256 previousPrice,
        uint256 price
    );

    constructor(ERC20 _erc20, ERC721 _erc721) {
        require(
            address(_erc20) != address(0),
            "Market: ERC20 contract address must be non-null"
        );
        require(
            address(_erc721) != address(0),
            "Market: ERC721 contract address must be non-null"
        );
        erc20 = _erc20;
        erc721 = _erc721;
    }

    function buy(uint256 _tokenId, uint256 _price) external {
        // 此处编写业务逻辑
        address buyer = msg.sender;
        address seller = orderOfId[_tokenId].seller;
        require(erc20.balanceOf(msg.sender)>=_price,'no more token');
        erc20.transferFrom(msg.sender,seller,_price);
        erc721.safeTransferFrom(address(this),buyer,_tokenId,"buy");
        removeListing(_tokenId);
        // orders[idToOrderIndex[_tokenId]]=orders[getOrderLength()-1];
        // idToOrderIndex[indesOrderId[getOrderLength()-1]] = idToOrderIndex[_tokenId];
        // orders.pop();
        emit Deal(buyer, seller, _tokenId, _price);
    }

    function cancelOrder(uint256 _tokenId) external {
        // 此处编写业务逻辑
        address seller = orderOfId[_tokenId].seller;
        removeListing(_tokenId);
        erc721.safeTransferFrom(address(this),seller,_tokenId,'back');
        // orders[idToOrderIndex[_tokenId]]=orders[getOrderLength()-1];
        // idToOrderIndex[indesOrderId[getOrderLength()-1]] = idToOrderIndex[_tokenId];
        // orders.pop();
        emit CancelOrder(seller, _tokenId);
    }
    //
    function changePrice(uint256 _tokenId, uint256 _price) external {
        // 此处编写业务逻辑
        address seller = orderOfId[_tokenId].seller;
        uint256 previousPrice = orderOfId[_tokenId].price;
        orderOfId[_tokenId].price = _price;
        emit ChangePrice(seller, _tokenId, previousPrice, _price);
    }

    function onERC721Received(
        address _operator,
        address _seller,
        uint256 _tokenId,
        bytes calldata _data
    ) public override returns (bytes4) {
        // 此处编写业务逻辑
        placeOrder(_seller, _tokenId,toUint256(_data, 0x0));
        // orderOfId[_tokenId].seller = _seller;
        // orderOfId[_tokenId].tokenId = _tokenId;
        // orderOfId[_tokenId].price = toUint256(_data, 0x0);
        // idToOrderIndex[_tokenId] = getOrderLength();
        // indesOrderId[getOrderLength()] = _tokenId;
        // orders.push(orderOfId[_tokenId]);
        return MAGIC_ON_ERC721_RECEIVED;
    }

    function isListed(uint256 _tokenId) public view returns (bool) {
        return orderOfId[_tokenId].seller != address(0);
    }

    function getOrderLength() public view returns (uint256) {
        return orders.length;
    }

    function placeOrder(
        address _seller,
        uint256 _tokenId,
        uint256 _price
    ) internal {
        // 此处编写业务逻辑
        orderOfId[_tokenId].seller = _seller;
        orderOfId[_tokenId].tokenId = _tokenId;
        orderOfId[_tokenId].price = _price;
        idToOrderIndex[_tokenId] = getOrderLength();
        indesOrderId[getOrderLength()] = _tokenId;
        orders.push(orderOfId[_tokenId]);
        emit NewOrder(_seller, _tokenId, _price);
    }

    function removeListing(uint256 _tokenId) internal {
        orders[idToOrderIndex[_tokenId]]=orders[getOrderLength()-1];
        idToOrderIndex[indesOrderId[getOrderLength()-1]] = idToOrderIndex[_tokenId];
        orders.pop();
        // 此处编写业务逻辑
    }
    // 0x00000000000000000000000000000000000000000000000AD78EBC5AC6200000
    // https://stackoverflow.com/questions/63252057/how-to-use-bytestouint-function-in-solidity-the-one-with-assembly
    function toUint256(bytes memory _bytes, uint256 _start)
        internal
        pure
        returns (uint256)
    {
        require(_start + 32 >= _start, "Market: toUint256_overflow");
        require(_bytes.length >= _start + 32, "Market: toUint256_outOfBounds");
        uint256 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x20), _start))
        }

        return tempUint;
    }
}
