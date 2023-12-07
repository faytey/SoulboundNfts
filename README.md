# SoulboundNFT Smart Contract Documentation

## Introduction

The contract ensures that each wallet can possess only one soulbound main token and allows the transaction of item tokens only between wallets possessing the soulbound main token.

## ERC1155 Token Standards

The contract adheres to the ERC1155 token standard, which is a multi-token standard on the Ethereum blockchain. It enables the creation of both fungible and non-fungible tokens within a single contract.

## Functionality

### Soulbound Main Token

- **Soulbound Token ID:** The contract defines a unique Soulbound Token ID (e.g., 1) representing the main character token.
- **Ownership Limitation:** Each wallet can own only one soulbound main token.
- **Ownership Tracking:** The contract keeps track of the owner of the soulbound token using a mapping.

### Item Tokens

- **Minting Item Tokens:** The contract allows the owner to mint item tokens that can only be transacted between wallets owning the soulbound main token.
- **Transferring Item Tokens:** Item tokens can be transferred between wallets, but only if both the sender and receiver own the soulbound main token.
- **Ownership Verification:** A modifier ensures that only the owner of the soulbound token can perform certain functions.

### Contract Deployment

- **Constructor:** The constructor function initializes the contract, mints a soulbound token to the contract creator, and designates the creator as the initial soulbound token owner.

### Administrative Functions

- **Minting Item Tokens:** The contract owner can mint item tokens and distribute them to wallet addresses owning the soulbound token.
- **Soulbound Token Ownership Transfer:** The ownership of the soulbound token can be transferred to another address by the contract owner.

## Deployment

To contract was built using foundry tooling and tested using `forge test` command, the contract was deployed to sepolia using the `forge create` command and can be accessed here https://sepolia.etherscan.io/address/0x3085c8f0e3edb907a6961cd361b0d01b13f522e3

## Usage

1. **Owning a Soulbound Token:**
   - Wallets can check if they own the soulbound token by calling the `ownsSoulboundToken` function.

2. **Minting Item Tokens:**
   - The contract owner can mint item tokens using the `mintItemTokens` function, providing the recipient's address, item IDs, and corresponding amounts.

3. **Transferring Item Tokens:**
   - Wallet owners can transfer item tokens to other wallets owning the soulbound token by calling the `transferItemTokens` function, providing the recipient's address, item IDs, and corresponding amounts.

4. **Transferring Soulbound Token Ownership:**
   - The contract owner can transfer the ownership of the soulbound token to another address using the `transferSoulboundTokenOwnership` function.
