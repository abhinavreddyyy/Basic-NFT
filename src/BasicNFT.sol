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

    /**
     * @notice Mints a new NFT with the provided metadata URI
     * @param tokenUri The IPFS URI pointing to the NFT metadata
     * @dev Uses _safeMint to ensure the receiving address can handle ERC721 tokens
     * Emits an {NFTMinted} event
     */
    function mintNFT(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        emit NFTMinted(s_tokenCounter, msg.sender, tokenUri);
        s_tokenCounter++;
    }

    /**
     * @notice Returns the metadata URI for a given token ID
     * @param tokenId The ID of the token to query
     * @return The IPFS URI pointing to the token's metadata
     * @dev Overrides the {ERC721-tokenURI} function to return custom IPFS URIs
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    /**
     * @notice Returns the total number of NFTs minted
     * @return The current token counter value
     */
    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
