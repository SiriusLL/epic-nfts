// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// Import OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// inhereit the contract we imported

contract EpicNFT is ERC721URIStorage {
    // Counter for TokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of the NFTs token and symbol
    constructor() ERC721("StarNft", "STAR") {
        console.log("This is my NFT contract. WOOOT!!!");
    }

    // minting function
    function mintEpicNFT() public {
        // Get current tokenId, starts from 0
        uint256 newTokenId = _tokenIds.current();

        //mint nft safely
        _safeMint(msg.sender, newTokenId);

        // Set NFTs data

        _setTokenURI(
            newTokenId,
            "data:application/json;base64,ewogICJuYW1lIjogIlB1cnBsZU1vbmtleVN1bktpc3MiLAogICJkZXNjcmlwdGlvbiI6ICJXaXNkb20gb2YgYSBEcmFnb24gdG8gZmlsbCB5b3VyIEpvdXJuZXkgd2l0aCBsaWdodC4iLAogICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStVSFZ5Y0d4bFRXOXVhMlY1VTNWdVMybHpjend2ZEdWNGRENEtQQzl6ZG1jKyIKfQ=="
        );
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newTokenId,
            msg.sender
        );

        _tokenIds.increment();
    }
}
