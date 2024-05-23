// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {Accumulator, SafetyFactorConfig, BPS_DENOMINATOR} from "../static/Structs.sol";

library AccumulatorLib {
    function init(
        Accumulator storage accumulator,
        uint256 tokensPerSecond
    ) external {
        accumulator.tokensPerSecond = tokensPerSecond;
        accumulator.prevTokensPerSecond = tokensPerSecond;
    }

    function overrideTokensPerSecond(
        Accumulator storage accumulator,
        uint256 tokensPerSecond,
        uint256 lastEpochUpdateTimestamp
    ) external {
        _adjustClaimableTokens(accumulator, 0, lastEpochUpdateTimestamp);

        accumulator.tokensPerSecond = tokensPerSecond;
        accumulator.prevTokensPerSecond = tokensPerSecond;
    }

    function adjustEpochFlow(
        Accumulator storage accumulator,
        SafetyFactorConfig memory config,
        int256 currentSafetyFactor,
        uint256 PRECISION,
        uint256 performanceFeeBPS,
        uint256 lastEpochUpdateTimestamp
    )
        external
        returns (uint256 newTokensPerSecond, uint256 prevTokensPerSecond)
    {
        _adjustClaimableTokens(
            accumulator,
            performanceFeeBPS,
            lastEpochUpdateTimestamp
        );

        prevTokensPerSecond = accumulator.tokensPerSecond;

        if (currentSafetyFactor > config.TARGET_SF_UPPER_BOUND) {
            newTokensPerSecond =
                (accumulator.tokensPerSecond * config.REDUCTION_FACTOR) /
                PRECISION;
        } else if (currentSafetyFactor < config.TARGET_SF_LOWER_BOUND) {
            newTokensPerSecond =
                accumulator.tokensPerSecond +
                (accumulator.tokensPerSecond * config.INCREASE_FACTOR) /
                PRECISION;
        } else {
            newTokensPerSecond = accumulator.tokensPerSecond;
        }

        accumulator.tokensPerSecond = newTokensPerSecond;
        accumulator.prevTokensPerSecond = prevTokensPerSecond;
    }

    function _calculateClaimableTokensAndFee(
        Accumulator memory accumulator,
        uint256 performanceFeeBPS,
        uint256 currentTimestamp,
        uint256 lastEpochUpdateTimestamp
    ) internal pure returns (uint256 tokensGained, uint256 fee) {
        uint256 elapsedTime = currentTimestamp - lastEpochUpdateTimestamp;

        if (accumulator.prevTokensPerSecond > accumulator.tokensPerSecond) {
            uint256 tokensSaved = elapsedTime *
                (accumulator.prevTokensPerSecond - accumulator.tokensPerSecond);
            fee = (tokensSaved * performanceFeeBPS) / BPS_DENOMINATOR;
        }

        tokensGained = (elapsedTime * accumulator.tokensPerSecond) - fee;
    }

    function _adjustClaimableTokens(
        Accumulator storage accumulator,
        uint256 lastEpochUpdateTimestamp,
        uint256 performanceFeeBPS
    ) internal {
        (uint256 tokensGained, uint256 fee) = _calculateClaimableTokensAndFee(
            accumulator,
            performanceFeeBPS,
            block.timestamp,
            lastEpochUpdateTimestamp
        );

        accumulator.claimableFees += fee;
        accumulator.claimableTokens += tokensGained;
        lastEpochUpdateTimestamp = block.timestamp;
    }
}
