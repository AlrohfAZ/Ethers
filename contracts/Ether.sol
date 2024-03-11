// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ether {
    address public owner;
    /* 0.001 Ether = 1000000 gwei
       0.001 Ether = 1000000000000000 wei
    */
    uint minAmount = 0.001 ether;
    /* 1 Ether = 1000000000 gwei
       1 Ether = 1000000000000000000 wei
    */
    uint maxAmount = 1 ether;
    mapping(address => uint256) public balances;

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function deposit(uint amount) public payable onlyOwner {
        require(amount >= minAmount && amount <= maxAmount);
        balances[msg.sender] += amount;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount > 0, "You must withdraw an amount greater than 0");
        require(
            amount <= balances[msg.sender],
            "You do not have enough funds to withdraw"
        );
        // Subtract the amount from the user's balance
        balances[msg.sender] -= amount;

        // Send the amount to the user
        payable(msg.sender).transfer(amount);
    }
}
