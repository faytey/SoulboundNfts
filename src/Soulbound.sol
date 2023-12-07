// SPDX-License-Identifier: MIT

// Compiler Version
pragma solidity ^0.8.19;

// Main standard that handles multitokens ERC1155
import "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";

// Main contract for handling ownership and access control
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Soulbound is ERC1155, Ownable {

    // Main token representing a character (soulbound)
    uint256 public constant SOULBOUND_TOKEN_ID = 1;

    // Mapping to keep track of the owner of the soulbound token
    mapping(address => bool) private soulboundTokenOwners;

    // Modifier to check if the caller owns the soulbound token
    modifier onlySoulboundTokenOwner() {
        require(soulboundTokenOwners[msg.sender], "Not owner of soulbound token");
        _;
    }

    constructor() ERC1155("https://ipfs.io/ipfs/bafybeigxgjr3bre3vvro7duzpz2j5tfrhwnarlqw6yq5cce6fo5qh3u7yq/{id}.json") Ownable(msg.sender){
        // Mint one soulbound token to the contract creator (can be adjusted based on your use case)
        _mint(msg.sender, SOULBOUND_TOKEN_ID, 1, "");
        soulboundTokenOwners[msg.sender] = true;
    }

    // Function to mint item tokens. Only callable by the contract owner.
    function mintItemTokens(address to, uint256[] memory itemIds, uint256[] memory amounts) external onlyOwner {
        // Check if the caller is the owner of the soulbound token
        require(soulboundTokenOwners[to], "No soulbound token found");

        // Mint the item tokens
        _mintBatch(to, itemIds, amounts, "");
    }

    // Function to transfer item tokens. Only callable by the owner of the soulbound token.
    function transferItemTokens(address from, address to, uint256[] memory itemIds, uint256[] memory amounts) external onlySoulboundTokenOwner {
        // Check if the recipient owns the soulbound token
        require(soulboundTokenOwners[to], "No soulbound token found");

        // Transfer the item tokens
        _safeBatchTransferFrom(from, to, itemIds, amounts, "");
    }

    // Function to check if an address owns the soulbound token
    function ownsSoulboundToken(address account) external view returns (bool) {
        return soulboundTokenOwners[account];
    }

    // Function to transfer ownership of the soulbound token. Only callable by the contract owner.
    function transferSoulboundTokenOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        require(!soulboundTokenOwners[newOwner], "New owner already owns the soulbound token");

        // Remove ownership from the current owner and assign it to the new owner
        soulboundTokenOwners[msg.sender] = false;
        soulboundTokenOwners[newOwner] = true;
    }
}
