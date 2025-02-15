// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Pausable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract MyToken is
    ERC1155,
    Ownable,
    ERC1155Pausable,
    ERC1155Supply,
    ReentrancyGuard
{
    constructor()
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(msg.sender)
    {}

    uint256 WhitelistMintPrice = 0.01 ether;
    uint256 PublicMintPrice = 0.02 ether;
    bool WhitelistMintOn;
    bool PublicMintOn;
    uint256 PublicMintLimit = 10;
    uint256 WhitelistMintLimit = 5;

    event Minted(address indexed account, uint256 id, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    mapping(address => bool) public whitelist;
    mapping(address => uint256) public publicMintPerUser;
    mapping(address => uint256) public whitelistMintPerUser;

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function EditWhiteListMintWindow() public onlyOwner {
        WhitelistMintOn = !WhitelistMintOn;
    }

    function EditPublicMintWindow() public onlyOwner {
        PublicMintOn = !PublicMintOn;
    }

    function MintWindow() public view returns (bool, bool) {
        return (WhitelistMintOn, PublicMintOn);
    }

    function addToWhitelist(address _user) onlyOwner {
        whitelist[_user] = true;
    }

    function removeFromWhitelist(address _user) onlyOwner {
        whitelist[_user] = false;
    }

    function isWhitelisted(address _user) public view returns (bool) {
        return whitelist[_user];
    }

    function publicMint(uint256 id, uint256 amount) public payable {
        require(PublicMintOn, "Public Mint is not available");
        require(msg.value == PublicMintPrice * amount, "Incorrect amount sent");
        require(amount <= PublicMintLimit, "Exceeds public mint limit");
        require(
            publicMintPerUser[msg.sender] + amount <= PublicMintLimit,
            "Exceeds public mint limit"
        );

        _mint(msg.sender, id, amount, "");
        emit Minted(msg.sender, id, amount);
    }

    function whitelistMint(uint256 id, uint256 amount) public payable {
        require(whitelist[msg.sender], "Not Whitelisted");
        require(WhitelistMintOn, "Whitelist Mint is not available");
        require(
            msg.value == WhitelistMintPrice * amount,
            "Incorrect amount sent"
        );
        require(amount <= WhitelistMintLimit, "Exceeds public mint limit");
        require(
            whitelistMintPerUser[msg.sender] + amount <= WhitelistMintLimit,
            "Exceeds public mint limit"
        );

        _mint(msg.sender, id, amount, "");
        emit Minted(msg.sender, id, amount);
    }

    function withdrawBalance() public onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");

        (bool success, ) = payable(owner()).call{value: balance}(""); // ✅ INTERACTION: Transfers funds
        require(success, "Withdrawal failed"); // ✅ EFFECT: Ensures success

        emit Withdraw(owner(), balance);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._update(from, to, ids, values);
    }
}
