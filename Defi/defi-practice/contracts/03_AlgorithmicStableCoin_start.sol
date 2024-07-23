// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./03_PriceFeed.sol";

contract AlgorithmicStablecoin is ERC20, Ownable {
    PriceFeed internal priceFeed;

    uint256 public targetPrice = 1 * 10 ** 8; // Target price of 1 USD with 8 decimals
    uint256 public expansionPercentage = 5; // 5% expansion or contraction

    constructor(
        uint256 initialSupply,
        address _priceFeed
    ) ERC20("Algo LPL", "ALLPL") {
        // 补全
        priceFeed = PriceFeed(_priceFeed);
        _mint(msg.sender, initialSupply);
    }

    function getLatestPrice() public view returns (uint256) {
        // 补全
        return priceFeed.getLatestPrice();
    }

    function adjustSupply() public onlyOwner {
        // 补全
        uint256 ratio = (uint256(getLatestPrice()) * 100)  / targetPrice ;
        if(ratio > 100){
            _mint(owner(), (balanceOf(owner()) * expansionPercentage) / 100);
        }
        if(ratio < 100){
            _burn(owner(), (balanceOf(owner()) * expansionPercentage) / 100);
        }
    }
}
