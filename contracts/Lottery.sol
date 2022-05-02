// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//Lottery Contract
contract Lottery {

    address public manager;
    address[] public players;
    address public currentWinner;

    constructor() {
        manager = msg.sender;
    }
    function enter() public payable {
        require(msg.value > 0.001 ether);

        players.push(msg.sender);
    }

    //Random number generator "Not that random"
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players)));
    }

    // Pick the winner
    function pickWinner() public restricted{
        uint index = random() % players.length;
        currentWinner = players[index];
        payable(players[index]).transfer(address(this).balance);
        players = new address[](0);
    }

    //Only the manager can pick the winner
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
    function getCurrentWinner() public view returns (address) {
        return currentWinner;
    }
}
