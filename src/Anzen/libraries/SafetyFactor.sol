// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {SafetyFactorUpdater, SafetyFactorConfig, LastEpochUpdate} from "../static/Structs.sol";

library SafetyFactorUpdaterLib {
    function updateConfig(
        SafetyFactorConfig storage config,
        int256 sf_desired_lower,
        int256 sf_desired_upper,
        uint256 reductionFactor,
        uint256 increaseFactor,
        uint256 minEpochDuration
    ) external {
        config.TARGET_SF_LOWER_BOUND = sf_desired_lower;
        config.TARGET_SF_UPPER_BOUND = sf_desired_upper;
        config.REDUCTION_FACTOR = reductionFactor;
        config.INCREASE_FACTOR = increaseFactor;
        config.minEpochDuration = minEpochDuration;
    }
}
