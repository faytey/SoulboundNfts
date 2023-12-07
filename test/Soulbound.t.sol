// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {Soulbound} from "../src/Soulbound.sol";

contract SoulboundTest is Test {
    Soulbound public soulbound;

    address owner = mkaddr('owner');
    address tester = mkaddr('tester');

    function setUp() public {
        vm.startPrank(owner);
        soulbound = new Soulbound();
        vm.stopPrank();
    }

    function test_Mintitemtokens() public {
        vm.startPrank(owner);
        uint256[] memory ids = new uint[](3);
        assert(ids.length == 3);
        ids[0] = 2;
        ids[1] = 3;
        ids[2] = 4;
        assert(ids[0] == 2);
        assert(ids[1] == 3);
        assert(ids[2] == 4);
        uint256[] memory amount = new uint[](3);
        amount[0] = 1;
        amount[1] = 1;
        amount[2] = 1;
        assert(amount[0] == 1);
        assert(amount[1] == 1);
        assert(amount[2] == 1);
        soulbound.mintItemTokens(owner, ids, amount);
        soulbound.balanceOf(owner, 1);
        soulbound.balanceOf(owner, 2);
        assert(soulbound.balanceOf(owner, 1) == 1);
        assert(soulbound.balanceOf(owner, 2) == 1);
        assert(soulbound.balanceOf(owner, 3) == 1);
        assert(soulbound.balanceOf(owner, 4) == 1);
        vm.stopPrank();
    }

    function test_Transferitemtokens() public {
        vm.startPrank(owner);
        uint256[] memory ids = new uint[](3);
        assert(ids.length == 3);
        ids[0] = 2;
        ids[1] = 3;
        ids[2] = 4;
        assert(ids[0] == 2);
        assert(ids[1] == 3);
        assert(ids[2] == 4);
        uint256[] memory amounts = new uint[](3);
        amounts[0] = 1;
        amounts[1] = 1;
        amounts[2] = 1;
        assert(amounts[0] == 1);
        assert(amounts[1] == 1);
        assert(amounts[2] == 1);
        soulbound.mintItemTokens(owner, ids, amounts);
        soulbound.transferItemTokens(owner, owner, ids, amounts);
        assert(soulbound.balanceOf(owner, 1) == 1);
        assert(soulbound.balanceOf(owner, 2) == 1);
        assert(soulbound.balanceOf(owner, 3) == 1);
        assert(soulbound.balanceOf(owner, 4) == 1);
        vm.stopPrank();
    }

    function test_OwnsSoulboundToken() public {
        vm.startPrank(owner);
        soulbound.ownsSoulboundToken(owner);
        assert(soulbound.balanceOf(owner, 1) == 1);
        vm.stopPrank();
    }

    function test_TransferSoulboundTokenOwnership() public {
        vm.startPrank(owner);
        soulbound.transferSoulboundTokenOwnership(tester);
        assert(soulbound.ownsSoulboundToken(tester) == true);
        vm.stopPrank();
    }


    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
