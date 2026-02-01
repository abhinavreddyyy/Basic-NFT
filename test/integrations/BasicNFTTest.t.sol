// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer; // variable to hold the deployer contract
    BasicNFT public basicNFT; // variable to hold the deployed BasicNFT contract
    address public USER = makeAddr("user");
    string public constant NARUTO_NFT_URI =
        "ipfs://QmYBwFv1oaFknnjd8yPzWHjvu9GT9mEqh9cT3V5UHmK93U";

    function setUp() external {
        deployer = new DeployBasicNFT(); // create a new instance of the deployer contract
        basicNFT = deployer.run(); // call the run function to deploy BasicNFT and get its address
    }

    function testNameIsCorrect() public view {
        // To compare two strings in solidity we use keccak256 hashing function
        string memory expectedName = "Naruto";
        string memory actualName = basicNFT.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(NARUTO_NFT_URI);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(NARUTO_NFT_URI)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }

    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNFT.mintNFT(NARUTO_NFT_URI);

        string memory tokenURI = basicNFT.tokenURI(0);
        assert(
            keccak256(abi.encodePacked(tokenURI)) ==
                keccak256(abi.encodePacked(NARUTO_NFT_URI))
        );
    }
}
