// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

import "@openzeppelin-upgrades/contracts/access/AccessControlUpgradeable.sol";
import "./interfaces/IRoleManager.sol";
import "./RoleManagerStorage.sol";

/// @title Manages roles and permissions within the protocol.
/// @notice This contract controls role assignments and permissions, safeguarded by an initializer role.
/// @dev Use caution with the owner role to prevent unauthorized access or renunciation that could freeze the contract.
contract RoleManager is
    IRoleManager,
    AccessControlUpgradeable,
    RoleManagerStorageV1
{
    /// @dev Blocks the contract's direct initialization to prevent its use as a standalone instance.
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice Initializes the contract with a role manager admin.
    /// @param roleManagerAdmin The address to be granted the default admin role.
    /// @dev Can only be called once immediately after deployment.
    function initialize(address roleManagerAdmin) external initializer {
        require(
            roleManagerAdmin != address(0),
            "RoleManager: Admin cannot be the zero address"
        );

        __AccessControl_init();
        _grantRole(DEFAULT_ADMIN_ROLE, roleManagerAdmin);
    }

    /// @notice Checks if an address has the RoleManager admin role.
    /// @param addressToCheck The address to verify.
    /// @return True if the address has the admin role, false otherwise.
    function isRoleManagerAdmin(
        address addressToCheck
    ) external view override returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, addressToCheck);
    }

    /// @notice Determines if an address is authorized to mint or burn rovBTC tokens.
    /// @param addressToCheck The address in question.
    /// @return True if the address is authorized, false otherwise.
    function isPaymentCoordinator(
        address addressToCheck
    ) external view override returns (bool) {
        return hasRole(PAYMENT_COORDINATOR, addressToCheck);
    }

    /// @notice Grants a role to an address.
    /// @param role The role to grant.
    /// @param account The address to grant the role to.
    function grantRole(
        bytes32 role,
        address account
    ) public override(IRoleManager, AccessControlUpgradeable) {
        _grantRole(role, account);
    }
}
