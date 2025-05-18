// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A minimal upgradeable proxy contract following the EIP-1967 standard.
contract Proxy {
    // This is the special storage slot for the implementation contract address,
    // defined by EIP-1967 to avoid storage collision.
    bytes32 internal constant IMPLEMENTATION_SLOT = 
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);

    // Admin address that has permission to upgrade the logic contract
    address public admin;

    // Constructor sets the initial logic contract and admin
    constructor(address _logic) {
        admin = msg.sender;        // Set the admin to the contract deployer
        setImplementation(_logic); // Store the initial implementation address
    }

    // Function to change the logic contract
    // Only callable by the admin
    function setImplementation(address _impl) public {
        require(msg.sender == admin, "Not admin"); // Access control

        // Store the new implementation address at the special EIP-1967 slot
        assembly {
            sstore(IMPLEMENTATION_SLOT, _impl)
        }
    }

    // The fallback function is triggered when no other function matches.
    // It forwards all calls to the current logic contract using delegatecall.
    fallback() external payable {
        assembly {
            // Load implementation address from storage slot
            let impl := sload(IMPLEMENTATION_SLOT)

            // Copy function call data to memory (from calldata)
            calldatacopy(0, 0, calldatasize())

            // Forward the call to the implementation contract using delegatecall
            let success := delegatecall(
                gas(),        // forward all gas
                impl,         // to this logic contract
                0,            // input data starts at 0
                calldatasize(), // length of input data
                0,            // output is stored at 0
                0             // length unknown yet
            )

            // Copy return data to memory
            returndatacopy(0, 0, returndatasize())

            // Return or revert based on result
            switch success
            case 0 {
                // If failed, revert with error data
                revert(0, returndatasize())
            }
            default {
                // If successful, return data
                return(0, returndatasize())
            }
        }
    }

    // This function allows the proxy to receive ETH
    receive() external payable {}
}
