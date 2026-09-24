// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RemixMessageStore {
    address public immutable owner;
    string private _message = "Hello from Remix";

    event MessageUpdated(address indexed updatedBy, string newMessage);

    error NotOwner();
    error EmptyMessage();

    constructor() {
        owner = msg.sender;
    }

    function message() external view returns (string memory) {
        return _message;
    }

    /// @notice Updates the stored message.
    /// @dev Only the contract owner can call this function. Empty messages are rejected.
    /// @param newMessage The new non-empty message to store on-chain.
    /// @custom:emits MessageUpdated when the stored message changes.
    function setMessage(string calldata newMessage) external {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        if (bytes(newMessage).length == 0) {
            revert EmptyMessage();
        }

        _message = newMessage;
        emit MessageUpdated(msg.sender, newMessage);
    }
}
