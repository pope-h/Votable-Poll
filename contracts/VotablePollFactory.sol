// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./VotablePoll.sol";

contract VotablePollFactory {
    VotablePoll[] VotablePollClones;

    event PollCreated(VotablePoll indexed pollAddress, address indexed creator);

    function createPoll() external returns (VotablePoll newPoll_, uint256 length_) {
        newPoll_ = new VotablePoll();
        VotablePollClones.push(newPoll_);

        length_ = VotablePollClones.length;
        emit PollCreated(newPoll_, msg.sender);
    }

    function fetchDeployedPolls() external view returns (VotablePoll[] memory) {
        return VotablePollClones;
    }
}