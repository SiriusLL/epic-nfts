// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// Import OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// inhereit the contract we imported

contract EpicNft is ERC721URIStorage {
    // Counter for TokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of the NFTs token and symbol
    constructor() ERC721("StarNft", "STAR") {
        console.log("This is my NFT contract. WOOOT!!!");
    }

    // minting function
    function mintEpicNft() public {
        // Get current tokenId, starts from 0
        uint256 newTokenId = _tokenIds.current();

        //mint nft safely
        _safeMint(msg.sender, newTokenId);

        // Set NFTs data

        _setTokenURI(newTokenId, "https://jsonkeeper.com/b/ZTEQ");
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newTokenId,
            msg.sender
        );

        _tokenIds.increment();
    }
}
