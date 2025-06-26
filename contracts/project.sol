// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SubscriptionService {
    address public owner;
    uint256 public monthlyFee;
    mapping(address => uint256) public subscribers;

    constructor(uint256 _monthlyFee) {
        owner = msg.sender;
        monthlyFee = _monthlyFee;
    }

    function subscribe() external payable {
        require(msg.value == monthlyFee, "Incorrect fee");
        subscribers[msg.sender] = block.timestamp + 30 days;
    }

    function isSubscribed(address user) external view returns (bool) {
        return subscribers[user] >= block.timestamp;
    }

    function updateFee(uint256 newFee) external {
        require(msg.sender == owner, "Only owner");
        monthlyFee = newFee;
    }
}
