// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// Import OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// helper function for base64 conversion contract
import {Base64} from "./libraries/Base64.sol";

// inhereit the contract we imported

contract EpicNFT is ERC721URIStorage {
    // Counter for TokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We split the SVG at the part where it asks for the background color.
    string svgPartOne =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string svgPartTwo =
        "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // arrays of words for randomizer
    string[] firstWords = [
        "Purple",
        "Yellow",
        "Pink",
        "PapayaWhip",
        "Honeydew",
        "Turquoise",
        "Chartreuse",
        "Rainbow",
        "Violet",
        "Indigo",
        "Tomato",
        "Ash"
    ];
    string[] secondWords = [
        "Monkey",
        "Starfish",
        "Narwhal",
        "Unicorn",
        "Stork",
        "Roadrunner",
        "Elephant",
        "snuffleupagus",
        "Sentient",
        "WoodPecker",
        "SeaDragon",
        "possum"
    ];
    string[] thirdWords = [
        "SunKiss",
        "Starkin",
        "Munchkin",
        "ButtMunch",
        "TwinkleToes",
        "BellyLaugher",
        "Tingler",
        "Sparkler",
        "Bumfuzzle",
        "Everywhen",
        "Cattywampus"
    ];

    // Get fancy with it! Declare a bunch of colors.
    string[] colors = ["red", "#08C2A8", "black", "yellow", "blue", "green"];

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    // Pass the name of the NFTs token and symbol
    constructor() ERC721("StarNft", "STAR") {
        console.log("This is my NFT contract. WOOOT!!!");
    }

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed random generator
        uint256 rando = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rando = rando % firstWords.length;
        return firstWords[rando];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed random generator
        uint256 rando = random(
            string(
                abi.encodePacked("   SECOND_WORD", Strings.toString(tokenId))
            )
        );
        rando = rando % secondWords.length;
        return secondWords[rando];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed random generator
        uint256 rando = random(
            string(abi.encodePacked("   THIRD_WORD", Strings.toString(tokenId)))
        );
        rando = rando % thirdWords.length;
        return thirdWords[rando];
    }

    // Same old stuff, pick a random color.
    function pickRandomColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rando = random(
            string(abi.encodePacked("COLOR", Strings.toString(tokenId)))
        );
        rando = rando % colors.length;
        return colors[rando];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // minting function
    function mintEpicNFT() public {
        // Get current tokenId, starts from 0
        uint256 newTokenId = _tokenIds.current();

        // grab random words from each array
        string memory first = pickRandomFirstWord(newTokenId);
        string memory second = pickRandomSecondWord(newTokenId);
        string memory third = pickRandomThirdWord(newTokenId);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        // Add the random color in.
        string memory randomColor = pickRandomColor(newTokenId);
        //concat string and close <text> <svg> tags
        string memory finalSvg = string(
            abi.encodePacked(
                svgPartOne,
                randomColor,
                svgPartTwo,
                combinedWord,
                "</text></svg>"
            )
        );

        // Get JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // set title of NFT to generated word
                        combinedWord,
                        '", "description": "Wisdom of a Dragon to fill your Journey with light.", "image": "data:image/svg+xml;base64,',
                        // add svg base url and append base64 encoded svg
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        //mint nft safely
        _safeMint(msg.sender, newTokenId);

        // Set NFTs data

        _setTokenURI(newTokenId, finalTokenUri);
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newTokenId,
            msg.sender
        );

        _tokenIds.increment();
        emit NewEpicNFTMinted(msg.sender, newTokenId);
    }
}
