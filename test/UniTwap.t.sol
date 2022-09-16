// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.12;

import "forge-std/Test.sol";

import {UniTwap} from "src/UniTwap.sol";

contract UniTwapTest is Test {
    
    UniTwap unitwap;
    // Goerli ETH UNI Univ3 pool address
    address constant internal poolAddress = 0x4d1892f15B03db24b55E73F9801826a56d6f0755;

    function setUp() external {
        unitwap = new UniTwap();
    }

    function testGetPrice() view external {
        console2.log("Returned X96 price is:");
        uint160 price = unitwap.getCurrentTwapFromPair(poolAddress,0);
        console2.log(price);
    }

    
}
