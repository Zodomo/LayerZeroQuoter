// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LayerZeroQuoter} from "../src/LayerZeroQuoter.sol";

contract LayerZeroQuoterScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
    }
}
