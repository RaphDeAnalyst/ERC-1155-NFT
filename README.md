# ERC-1155-NFT


![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-4.5.0-blue)

An ERC-1155 smart contract for minting NFTs with whitelist functionality. This contract includes features like pausable tokens, supply tracking, and secure withdrawals. Built with OpenZeppelin and Solidity.

## Features
- **Whitelist Minting**: Only whitelisted addresses can mint during the whitelist phase.
- **Public Minting**: Open to everyone after the whitelist phase.
- **Pausable**: The contract owner can pause/unpause minting.
- **Supply Tracking**: Tracks total supply of each token ID.
- **Secure Withdrawals**: Contract owner can securely withdraw funds.

## Getting Started
### Prerequisites
- A Solidity development environment (e.g., [Foundry](https://getfoundry.sh/), [Hardhat](https://hardhat.org/), [Truffle](https://trufflesuite.com/), or [Remix](https://remix.ethereum.org/)).
- An Ethereum wallet (e.g., MetaMask).
- Testnet ETH (for deployment on testnets).

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ERC-1155-NFT.git
   cd ERC-1155-NFT

2. Set up your development environment:
    * Foundry:
      ```bash
      curl -L https://foundry.paradigm.xyz | bash
      foundryup
      forge install OpenZeppelin/openzeppelin-contracts
      forge remappings > remappings.txt
      
    * Hardhat:
     ```bash
       npm install --save-dev hardhat
       npm install @openzeppelin/contracts
     ```    
   * Truffle:
      ```bash
      npm install -g truffle
      npm install @openzeppelin/contracts
      ```
   
4. Compile the contract:
   * Foundry:
     ```
     forge build
     ```
   * Hardhat:
    ```
    npx hardhat compile
    ```
   * Truffle:
    ```
    truffle compile
    
### Deployment
#### Steps
1. Update the constructor in MyToken.sol with your IPFS URI.
2. Deploy the contract using your preferred tool:
   * Foundry:
     ```
     forge create --rpc-url <YOUR_RPC_URL> --private-key <YOUR_PRIVATE_KEY> src/MyToken.sol:MyToken --constructor-args "ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/"
    * Hardhat:
      Create a deployment script (scripts/deploy.js) and run:
      ```
      npx hardhat run scripts/deploy.js --network <NETWORK_NAME>
    *Truffle:
      Update truffle-config.js and run:
      ```
      truffle migrate --network <NETWORK_NAME>
### Usage
#### Whitelist Minting
1. Add addresses to the whitelist using the addToWhitelist function.
2. Toggle the whitelist mint window using EditWhiteListMintWindow.
3. Whitelisted users can mint tokens by calling whitelistMint.

#### Public Minting
1. Toggle the public mint window using EditPublicMintWindow.
2. Users can mint tokens by calling publicMint.

#### Withdrawing Funds
1. The contract owner can withdraw funds using the withdrawBalance function.

#### Testing
1. Run tests using your preferred tool:
   * Foundry: forge test
   * Hardhat: npx hardhat test
   * Truffle: truffle test

#### Contract Details
   * Token Standard: ERC-1155
   * License: MIT
   * Solidity Version: 0.8.22
   * OpenZeppelin Version: ^5.0.0

#### Contributing
Contributions are welcome! Please open an issue or submit a pull request.
