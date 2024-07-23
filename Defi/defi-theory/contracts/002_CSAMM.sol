// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract CSAMM {
    IERC20 immutable token0;
    IERC20 immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address _to, uint _amount) private {
        // 此处补全
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from, uint _amount) private {
        // 此处补全
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    function swap(
        address _tokenIn,
        uint _amountIn
    ) external returns (uint amountOut) {
        // 此处补全
        require(_tokenIn == address(token0) || _tokenIn == address(token1),"error input tokenaddress");
        require(_amountIn > 0 ,"error input _amount");
        bool istoken0 = _tokenIn == address(token0);
        IERC20(_tokenIn).transferFrom(msg.sender,address(this),_amountIn);
        amountOut = _amountIn;
        istoken0? 
        token1.transfer(msg.sender,amountOut):
        token0.transfer(msg.sender,amountOut);
        istoken0?
        _update(reserve0 + _amountIn, reserve1 - _amountIn):
        _update(reserve0 - _amountIn, reserve1 + _amountIn);
    }

    function addLiquidity(
        uint _amount0,
        uint _amount1
    ) external returns (uint shares) {
        // 此处补全
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);
        if (totalSupply == 0){
            shares = (_amount0 + _amount1) / 2;
            _mint(msg.sender, shares);
        }else {
            shares = ((_amount0 + _amount1) * totalSupply) / (reserve0 + reserve1);
            _mint(msg.sender, shares);
        }
        _update(reserve0 + _amount0, reserve1 + _amount1);
    }

    function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {
        // 此处补全
        require(_shares > 0 ,"error _shares");
        
        d0 = (_shares * reserve0) / totalSupply;
        d1 = (_shares * reserve1) / totalSupply;
        token0.transfer(msg.sender, d0);
        token1.transfer(msg.sender, d1);
        _burn(msg.sender, _shares);
        _update(reserve0 - d0, reserve1 - d1);
    }

    function _update(uint _res0, uint _res1) private {
        reserve0 = _res0;
        reserve1 = _res1;
    }
}
contract zp is ERC20{
    constructor() ERC20("zp","zp") public {
        _mint(msg.sender, 1000);
    }
}
contract ZP is ERC20{
    constructor() ERC20("ZP","ZP") public {
        _mint(msg.sender, 1000);
    }
}