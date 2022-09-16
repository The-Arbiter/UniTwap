// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.12;

import "v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "v3-core/contracts/libraries/TickMath.sol";
import "v3-core/contracts/libraries/FixedPoint96.sol";
import "v3-core/contracts/libraries/FullMath.sol";

/// @title UniTwap allows you to fetch Q64.96 (x96) prices from UniSwap and generate time weighted average prices
contract UniTwap {

  /// @dev Wrapper for the other two functions
  function getCurrentTwapFromPair(address uniswapV3Pool, uint32 twapInterval) public view returns (uint256 priceX96){
    return getPriceX96FromSqrtPriceX96(getSqrtTwapX96(uniswapV3Pool,twapInterval));
  }
 
  /**
  * @dev Gets sqrtTwapX96 value from some UniV3 pool for a given twapInterval
  * @param uniswapV3Pool => Address of the pool
  * @param twapInterval => TWAP interval in seconds
  * @dev slot0 used for => sqrtPriceX96 The current price of the pool as a sqrt(token1/token0) Q64.96 value
  * @dev observe used for => tickCumulatives The cumulative tick values at `secondsAgo` seconds before block.timestamp  
  * @dev NOTE Tick has some rounding issues which should be investigated for security vulns
  * @return sqrtPriceX96 => SqrtX96 price for the pool over the interval 
  */
  function getSqrtTwapX96(address uniswapV3Pool, uint32 twapInterval) internal view returns (uint160 sqrtPriceX96) {

        // For the first (0th) interval => Return the current sqrtPriceX96 (as a sqrt(token1/token0))
        if (twapInterval == 0) {
            // return the current price for the 0th interval
            (sqrtPriceX96, , , , , , ) = IUniswapV3Pool(uniswapV3Pool).slot0();
        } 
        // For all other intervals => Return the sqrtPriceX96
        else {
            uint32[] memory secondsAgos = new uint32[](2); /// @dev This is what UniV3Core calls it
            secondsAgos[0] = twapInterval; // {twapInterval} seconds before now
            secondsAgos[1] = 0; // 0 seconds before now (current block.timestamp)

            // Get the tick values as of each time before now
            (int56[] memory tickCumulatives, ) = IUniswapV3Pool(uniswapV3Pool).observe(secondsBeforeNow);
            
            /// @dev Tick is somewhat imprecise as it is rounded to the nearest integer... Need to investigate security concerns.
            sqrtPriceX96 = TickMath.getSqrtRatioAtTick(
                int24((tickCumulatives[1] - tickCumulatives[0]) / twapInterval)
            );
        }
    }

    /**
    * @dev Converts SqrtPriceX96 to PriceX96 using FullMath
    * @param sqrtPriceX96 => SqrtX96 value to convert
    * @return priceX96 => Converted SqrtX96 value
    */
    function getPriceX96FromSqrtPriceX96(uint160 sqrtPriceX96) internal pure returns(uint256 priceX96) {
        return FullMath.mulDiv(sqrtPriceX96, sqrtPriceX96, FixedPoint96.Q96);
    }

}
