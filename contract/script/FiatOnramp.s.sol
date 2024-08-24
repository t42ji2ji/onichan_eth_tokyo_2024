// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StubVerifier} from "../src/StubVerifier.sol";
import {FiatOnramp} from "../src/FiatOnramp.sol";

contract FiatOnrampScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        StubVerifier stubVerifier = new StubVerifier();
        FiatOnramp fiatOnramp = new FiatOnramp(address(stubVerifier));

        vm.stopBroadcast();
    }
}
