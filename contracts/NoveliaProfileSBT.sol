// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.7.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol";

contract NovelSBT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    event Attest(address indexed to, uint256 indexed tokenId);
    event Revoke(address indexed to, uint256 indexed tokenId);
    uint256 public mintPrice;
    uint256 public maxPerWallet;
    mapping(address => uint256) public walletMints;
    address withdrawWallet;
    constructor() ERC721("Novelia Profile NFT", "NVP") {
        mintPrice = 10000000000000000;
        maxPerWallet = 1;
        withdrawWallet = msg.sender;
    }

    function changeSetup(uint256 _mintPrice, address _withdrawWallet, uint256 _maxPerWallet) external onlyOwner {
        mintPrice = _mintPrice;
        maxPerWallet = _maxPerWallet;
        withdrawWallet = _withdrawWallet;
    }

    function mint() public payable {
        require(msg.value == mintPrice, "Price not correct");
        require(walletMints[msg.sender] < maxPerWallet);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        walletMints[msg.sender] ++;
        _safeMint(msg.sender, tokenId);
    }

    function withdraw() external onlyOwner {
        (bool success,) = withdrawWallet.call{value:address(this).balance}("");
        require(success, "Transfer failed!");
    }

    function burn(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Only owner of the token can burn it");
        _burn(tokenId);
    }

    function revoke(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256) pure override internal {
        require(from == address(0) || to == address(0), "Not allowed to transfer token");
    }

    function _afterTokenTransfer(address from, address to, uint256 tokenId) override internal {

        if (from == address(0)) {
            emit Attest(to, tokenId);
        } else if (to == address(0)) {
            emit Revoke(to, tokenId);
        }
    }



}
