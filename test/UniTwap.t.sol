// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

import {UniTwap} from "src/UniTwap.sol";

contract UniTwapTest is Test {
    
    UniTwap unitwap;

    function setUp() external {
        unitwap = new UniTwap();
    }

    function testExample() external {
    }
}
