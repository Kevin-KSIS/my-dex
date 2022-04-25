// SPDX-License-Identifier: MIT
pragma solidity =0.6.12;

// The contract must compile with Solidity 0.6.12. Because the IUniswapV2Router01 and 02 used a version >=0.6.2
// When implement it that functions defined are "pure", can not. (introduce in Solidity v0.7.0)

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract KevRouter02 is IUniswapV2Router02 {
    address public immutable override factory;
    address public immutable override WETH;

    constructor(address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) override external returns (uint amountA, uint amountB, uint liquidity) {}
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) override external payable returns (uint amountToken, uint amountETH, uint liquidity) {}
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) override external returns (uint amountA, uint amountB) {}
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) override external returns (uint amountToken, uint amountETH) {}
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) override external returns (uint amountA, uint amountB) {}
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) override external returns (uint amountToken, uint amountETH) {}
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) override external returns (uint[] memory amounts) {}
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) override external returns (uint[] memory amounts) {}
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        override external
        payable
        returns (uint[] memory amounts) {}
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        override external
        returns (uint[] memory amounts) {}
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        override external
        returns (uint[] memory amounts) {}
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        override external
        payable
        returns (uint[] memory amounts) {}

    function quote(uint amountA, uint reserveA, uint reserveB) override external pure returns (uint amountB) {}
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) override external  pure returns (uint amountOut) {}
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) override external  pure returns (uint amountIn) {}
    function getAmountsOut(uint amountIn, address[] calldata path) override external  view returns (uint[] memory amounts) {}
    function getAmountsIn(uint amountOut, address[] calldata path) override external  view returns (uint[] memory amounts) {}

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token, uint liquidity, uint amountTokenMin,
        uint amountETHMin, address to, uint deadline
    ) override external  returns (uint amountETH){}

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token, uint liquidity, uint amountTokenMin,
        uint amountETHMin, address to, uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) override external returns (uint amountETH){}

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn, uint amountOutMin, address[] calldata path,
        address to, uint deadline
    ) override external{}

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin, address[] calldata path,
        address to, uint deadline
    ) override external payable{}

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn, uint amountOutMin,
        address[] calldata path, address to, uint deadline
    ) override external {}
}
