// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Minimal counter for testnet practice (Week 1)
/// @notice Deploy on a public testnet, then verify read/write on block explorer.
contract Counter {
    uint256 public number;

    event Incremented(uint256 newValue);

    function increment() external {
        number += 1;
        emit Incremented(number);
    }

    /// @dev View read — no transaction gas for off-chain `eth_call`
    function getNumber() external view returns (uint256) {
        return number;
    }
}
