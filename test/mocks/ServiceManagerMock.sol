// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.12;

import "../../src/ServiceManagerBase.sol";

contract ServiceManagerMock is ServiceManagerBase {
    constructor(
        IAVSDirectory _avsDirectory,
        IPaymentCoordinator _paymentCoordinator,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        IRoleManager _roleManager
    )
        ServiceManagerBase(
            _avsDirectory,
            _paymentCoordinator,
            _registryCoordinator,
            _stakeRegistry,
            _roleManager
        )
    {}

    function initialize(address initialOwner) public virtual initializer {
        __ServiceManagerBase_init(initialOwner);
    }
}
