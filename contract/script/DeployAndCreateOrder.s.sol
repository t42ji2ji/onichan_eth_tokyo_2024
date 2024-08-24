// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StubVerifier} from "../src/StubVerifier.sol";
import {FiatOnramp} from "../src/FiatOnramp.sol";
import {USDT} from "../src/USDT.sol";
import {USDC} from "../src/USDC.sol";
import "forge-std/console.sol";

contract DeployAndCreateOrderScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Deploy StubVerifier
        StubVerifier verifier = new StubVerifier();

        // Deploy FiatOnramp
        FiatOnramp fiatOnramp = new FiatOnramp(address(verifier));
        console.logAddress(address(fiatOnramp));

        // Deploy ERC20 tokens
        USDT usdt = new USDT();
        USDC usdc = new USDC();
        console.logAddress(address(usdt));
        console.logAddress(address(usdc));

        // Approve tokens for FiatOnramp
        usdt.approve(address(fiatOnramp), 1000000000000000000);
        usdc.approve(address(fiatOnramp), 1000000000000000000);

        // Create orders
        fiatOnramp.createOrder(address(usdt), 150000000, 1);
        fiatOnramp.createOrder(address(usdc), 100000000, 2);
        fiatOnramp.createOrder(address(usdc), 200000000, 3);

        vm.stopBroadcast();
    }
}
