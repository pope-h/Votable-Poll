// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./IVotablePoll.sol";

contract VotablePoll {
    address public creator;

    struct Option {
        string name;
        uint voteCount;
    }

    struct Poll {
        string question;
        mapping(uint8 => Option) options;
        uint optionCount;
        mapping(address => bool) hasVoted;
        bool isOpen;
    }

    mapping(string => Poll) public polls;
    mapping(address => bool) public isAdmin;

    modifier onlyCreator() {
        require(msg.sender == creator, "Only creator can call this function");
        _;
    }

    modifier onlyAdmin() {
        require(isAdmin[msg.sender], "Only admin can call this function");
        _;
    }

    constructor() {
        creator = msg.sender;
        isAdmin[msg.sender] = true;
    }

    function addAdmin(address _admin) external onlyCreator {
        isAdmin[_admin] = true;
    }

    function createPoll(string memory _question) external onlyAdmin {
        require(!polls[_question].isOpen, "Poll already created");

        polls[_question].question = _question;
        polls[_question].isOpen = true;
    }

    function addOption(string memory _question, uint8 _index, string memory _option) external onlyAdmin {
        require(polls[_question].isOpen, "Poll is not open for adding options");
        require(bytes(_option).length > 0, "Option name cannot be empty");
        require(!optionExists(_question, _index), "Option already exists for this question");

        polls[_question].options[_index].name = _option;
        polls[_question].optionCount++;
    }

    function getQuestionOption(string memory _question, uint8 _index) external view returns (Option memory) {
        return polls[_question].options[_index];
    }

    function vote(string memory _question, uint8 _index) external {
        require(polls[_question].isOpen, "Poll is not open for voting");
        require(polls[_question].hasVoted[msg.sender], "You have already voted");

        polls[_question].options[_index].voteCount++;
        polls[_question].hasVoted[msg.sender] = true;
    }

    function closePoll(string memory _question) external onlyAdmin {
        polls[_question].isOpen = false;
    }

    function getOptionVoteCount(string memory _question, uint8 _index) external view returns (uint) {
        return polls[_question].options[_index].voteCount;
    }

    function optionExists(string memory _question, uint8 _index) private view returns (bool) {
        return bytes(polls[_question].options[_index].name).length > 0;
    }
}