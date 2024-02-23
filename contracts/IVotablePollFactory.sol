// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./VotablePoll.sol";

interface IVotablePollFactory {
    function createPoll() external returns (VotablePoll newPoll_, uint256 length_);
    function fetchDeployedPolls() external view returns (VotablePoll[] memory);
}