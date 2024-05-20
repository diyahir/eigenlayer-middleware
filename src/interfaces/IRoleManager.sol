// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

interface IRoleManager {
    /// @dev Returns whether the specified address has permissions to manage RoleManager
    /// @param addressToCheck Address to check
    function isRoleManagerAdmin(
        address addressToCheck
    ) external view returns (bool);

    /// @dev Returns whether the specified address has permission to update config on the Payment Coordinator
    /// @param addressToCheck Address to check
    function isPaymentCoordinator(
        address addressToCheck
    ) external view returns (bool);

    /// @dev Grants a role to an address
    /// @param role Role to grant
    /// @param account Address to grant role to
    function grantRole(bytes32 role, address account) external;
}
