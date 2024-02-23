// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IVotablePoll {
    function creator() external view returns (address);
    function isAdmin(address _address) external view returns (bool);
    function addAdmin(address _admin) external;
    function createPoll(string memory _question) external;
    function addOption(string memory _question, string memory _option) external;
    function vote(string memory _question, string memory _option) external;
    function closePoll(string memory _question) external;
    function getOptionVoteCount(string memory _question, string memory _option) external view returns (uint);
}