// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC721.sol";

contract ZP is ERC721 {
    uint public MAX_LPLS = 10; // 总量

    // 构造函数
    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://voidtech.cn/application/thumb.php?img=/i/2022/11/22/qizjig.jpg";
    }

    address owner = msg.sender;
    uint tokenId = 0; 

    // 铸造函数
    function mint(address to) external {
        require(msg.sender == owner && tokenId >= 0 && tokenId < MAX_LPLS, "you are not owner or tokenId out of range");
        tokenId ++;
        _mint(to, tokenId);
    }

}

