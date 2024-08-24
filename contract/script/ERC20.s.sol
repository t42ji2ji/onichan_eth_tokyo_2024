// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StubVerifier} from "../src/StubVerifier.sol";
import {USDT} from "../src/USDT.sol";
import {USDC} from "../src/USDC.sol";
import "forge-std/console.sol";

contract DeployERC20Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        USDT usdt = new USDT();
        USDC usdc = new USDC();
        console.logAddress(address(usdt));
        console.logAddress(address(usdc));

        vm.stopBroadcast();
    }
}
