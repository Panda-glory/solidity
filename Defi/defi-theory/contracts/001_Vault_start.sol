// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Vault {
  IERC20 public immutable token;

  uint public totalSupply;
  mapping(address => uint) public balanceOf;

  constructor(address _token) {
    token = IERC20(_token);
  }

  function _mint(address _to, uint _amount) private {
    balanceOf[_to] += _amount;
    totalSupply += _amount;
  }

  function _burn(address _from, uint _amount) private {
    balanceOf[_from] -= _amount;
    totalSupply -= _amount;
  }

  function deposit(uint _amount) external {
    require(_amount > 0, "_amount cannot 0");
    token.transferFrom(msg.sender, address(this), _amount);
    _mint(msg.sender, _amount);
  }

  function withdraw(uint _shares) external {
    require(_shares > 0, "_shares cannot 0");
    uint256 amount = token.balanceOf(address(this)) * (_shares / totalSupply);
    _burn(msg.sender, _shares);
    token.transfer(msg.sender, amount);
  }
}
contract ZP is ERC20{
  constructor() ERC20("ZP","ZP") public {
    _mint(msg.sender, 100000000000 * 10 **18);
  }
}