// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RemixMessageStore {
    address public immutable owner;
    string private _message = "Hello from Remix";

    event MessageUpdated(address indexed updatedBy, string newMessage);

    error NotOwner();

    constructor() {
        owner = msg.sender;
    }

    function message() external view returns (string memory) {
        return _message;
    }

    function setMessage(string calldata newMessage) external {
        if (msg.sender != owner) {
            revert NotOwner();
        }

        _message = newMessage;
        emit MessageUpdated(msg.sender, newMessage);
    }
}
