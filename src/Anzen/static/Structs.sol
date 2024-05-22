// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

enum SafetyFactorStatus {
    Operational,
    Inactive
}

struct SafetyFactorConfig {
    int256 TARGET_SF_LOWER_BOUND;
    int256 TARGET_SF_UPPER_BOUND;
    uint256 REDUCTION_FACTOR;
    uint256 INCREASE_FACTOR;
    address admin;
    uint256 minEpochDuration;
}

struct LastEpochUpdate {
    uint256 claimableTokens;
    uint256 claimableFees;
    uint256 tokensPerSecond;
    uint256 prevTokensPerSecond;
    uint256 lastEpochUpdateTimestamp;
}

struct SafetyFactorUpdater {
    SafetyFactorConfig safetyFactorConfig;
    LastEpochUpdate lastEpochUpdate;
}
