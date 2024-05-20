// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

/// @title RoleManager Storage Version 1
/// @dev Stores variables for RoleManager, ensuring upgrade safety.
/// Upgrade by inheriting from newer versions to maintain the storage layout.
contract RoleManagerStorageV1 {
    /// @dev Role identifier for minting/burning rovBTC tokens.
    bytes32 public constant PAYMENT_COORDINATOR = keccak256("PAYMENT_COORDINATOR");
}

// Example for the next version upgrade storage.
// Note: Define new storage variables here following the upgrade to avoid storage layout issues.
// contract RoleManagerStorageV2 is RoleManagerStorageV1 {}
