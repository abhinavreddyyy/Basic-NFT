// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol"; // DevOpsTools helps in getting most recent deployment

contract MintBasicNFT is Script {
    // this script will mint a new NFT from the deployed BasicNFT contract

    string public constant TOKENURI =
        "ipfs://QmYBwFv1oaFknnjd8yPzWHjvu9GT9mEqh9cT3V5UHmK93U";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        ); // gets the most recently deployed BasicNFT contract address
        mintNftOnContract(mostRecentlyDeployed); // this code of line mints the NFT
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(TOKENURI);
        vm.stopBroadcast();
    }
}
