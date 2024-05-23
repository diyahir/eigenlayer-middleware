// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

uint256 constant BPS_DENOMINATOR = 10_000; // 10,000

enum SafetyFactorStatus {
    Operational,
    Inactive
}

struct SafetyFactorConfig {
    int256 TARGET_SF_LOWER_BOUND;
    int256 TARGET_SF_UPPER_BOUND;
    uint256 REDUCTION_FACTOR;
    uint256 INCREASE_FACTOR;
    uint256 minEpochDuration;
}

struct Accumulator {
    uint256 claimableTokens;
    uint256 claimableFees;
    uint256 tokensPerSecond;
    uint256 prevTokensPerSecond;
}
