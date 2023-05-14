// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.7.0/token/ERC20/ERC20.sol";

contract NoveliaCollectionSBT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter public _tokenIdCounter;
    event Attest(address indexed to, uint256 indexed tokenId);
    event Revoke(address indexed to, uint256 indexed tokenId);
    uint256 public mintPrice;
    uint256 public maxPerWallet;
    mapping(address => uint256) public walletMints;
    address withdrawWallet;
    ERC20 NOVEL;
    address public platformWallet;
    address public NOVELTokenAddress;
    
    constructor(address _platformWallet, address _NOVELTokenAddress) ERC721("Novelia Collection SBT", "NOVEL") {
        mintPrice = 0;
        maxPerWallet = 1;
        withdrawWallet = msg.sender;
        NOVEL = ERC20(NOVELTokenAddress);
        platformWallet = _platformWallet;
        NOVELTokenAddress = _NOVELTokenAddress;
    }

    function changeMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    function mint() public {
        require(NOVEL.balanceOf(msg.sender)>mintPrice, "Price not correct");
        require(walletMints[msg.sender] < maxPerWallet);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        walletMints[msg.sender] ++;
        NOVEL.transferFrom(msg.sender, address(this), mintPrice);
        _safeMint(msg.sender, tokenId);
    }

    function donate(uint256 amount) public{
        require(NOVEL.balanceOf(msg.sender)>amount, "Insufficent fund");
        NOVEL.transferFrom(msg.sender, address(this), amount);

    }

    function claim() external onlyOwner {
        NOVEL.transfer(msg.sender, NOVEL.balanceOf(address(this))*9/10);
        NOVEL.transfer(address(platformWallet), NOVEL.balanceOf(address(this)));
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
