# UniTwap

**Takes a UniV3 pool and does TWAP calculations, returning values as X96.**

Caveats / warnings:

- This uses ticks which can have rounding errors due to them rounding and storing as integers
- Fullmath returns a X96 (64 bit int, 96 bit float) as uint256 not uint160 and I have cast it to 160 bits, though this needs thorough testing to ensure it can always be cast correctly
- Math libraries restrict Solidity version to >=0.5.0 through to <0.8.0

### Dev Guide

*The following instructions are for Goerli.*

You can run `cast call 0x4d1892f15B03db24b55E73F9801826a56d6f0755 "slot0()(uint160 sqrtPriceX96, int24 tick, uint16 observationIndex, uint16 observationCardinality, uint16 observationCardinalityNext, uint8 feeProtocol, bool unlocked)"` to get the values from `slot0` (sqrtX96 price).

/** @dev Addresses to make testing easier :)
*   UniV3 Goerli Router => 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45
*   UniV3 Goerli Factory => 0x1f98431c8ad98523631ae4a59f267346ea31f984
*   UNI token Goerli => 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
*   WETH Goerli => 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6
*   UNIWETH v3 Goerli Pool => 0x4d1892f15B03db24b55E73F9801826a56d6f0755
*/


## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
