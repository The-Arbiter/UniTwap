// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "v3-core/contracts/interfaces/IUniswapV3Pool.sol";
//import "v3-core/contracts/libraries/TickMath.sol"; Math conflicts

/// @title UniTwap allows you to fetch Q64.96 (x96) prices from UniSwap and generate time weighted average prices
contract UniTwap {
 

  constructor() {
  }

  /* /// @dev Fetches current price in ticks from Uniswap pool.
    function getTick() public view returns (int24 tick) {
        (, tick, , , , , ) = pool.slot0();
    }

    /// @dev Fetches time-weighted average price in ticks from Uniswap pool.
    function getTwap() public view returns (int24) {
        uint32 _twapDuration = twapDuration;
        uint32[] memory secondsAgo = new uint32[](2);
        secondsAgo[0] = _twapDuration;
        secondsAgo[1] = 0;

        (int56[] memory tickCumulatives, ) = pool.observe(secondsAgo);
        return int24((tickCumulatives[1] - tickCumulatives[0]) / _twapDuration);
    }
     */

}
