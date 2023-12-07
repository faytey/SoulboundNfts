// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {Soulbound} from "../src/Soulbound.sol";

contract SoulboundScript is Script {
    Soulbound public soulbound;

    function setUp() public {
        soulbound = new Soulbound();
    }

    function run() public {
        vm.broadcast();
    }
}
