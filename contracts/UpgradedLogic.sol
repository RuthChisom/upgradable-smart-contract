// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is the upgraded logic contract.
// It increments the counter by 2 instead of 1 and has a reset function.
contract UpgradedLogic {
    // Public variable to store the count
    uint public count;

    // Function to increment the counter by 2
    function increment() public {
        count += 2; // Modified logic
    }

    // Function to reset the counter to zero
    function reset() public {
        count = 0;
    }
}
