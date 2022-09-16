# UniTwap

**Takes a UniV3 pool and does TWAP calculations, returning values as X96.**

Caveats / warnings:

- This uses ticks which can have rounding errors due to them rounding and storing as integers
- Fullmath returns a X96 (64 bit int, 96 bit float) as uint256 not uint120 and I have cast it to 120 bits, though this needs thorough testing to ensure it can always be cast correctly
- Math libraries restrict Solidity version to >=0.5.0 through to <0.8.0


## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
