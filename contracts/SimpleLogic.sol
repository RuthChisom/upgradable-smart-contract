// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is a basic logic contract for demonstration.
// It has a counter that increases by 1 each time `increment()` is called.
contract SimpleLogic {
    // Public variable to store the count
    uint public count;

    // Function to increment the counter by 1
    function increment() public {
        count += 1;
    }
}
