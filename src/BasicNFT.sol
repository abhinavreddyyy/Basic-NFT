// SPDX-License-Identifier: MIT
/**
 * @title BasicNFT
 * @author Your Name
 * @notice A simple ERC721 NFT contract for minting Naruto-themed NFTs
 * @dev This contract demonstrates basic NFT functionality with IPFS metadata storage
 */

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    /// @notice Counter for tracking total NFTs minted
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri; // basically to make all the naruto tokens unique

    constructor() ERC721("Naruto", "NAR") {
        s_tokenCounter = 0;
    }

    // most of the logic of these functions and all are taken from eips.ethereum.org/EIPs/eip-721
    function mintNFT(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); // _safeMint is from ERC721
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        /* tokenURI indentifies resource(uint256 tokenId here), overided from ERC721 
        (has it's own virtual tokenURI function) and it returns a string(because URI is string)
        which points to the correct location  in IPFS where the metadata for a particular tokenId is stored 
        */
        // return "ipfs://QmYBwFv1oaFknnjd8yPzWHjvu9GT9mEqh9cT3V5UHmK93U"; // ipfs of metadata
        return s_tokenIdToUri[tokenId];
    }
}
