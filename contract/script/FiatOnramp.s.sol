// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StubVerifier} from "../src/StubVerifier.sol";
import {FiatOnramp} from "../src/FiatOnramp.sol";
import "forge-std/console.sol";

contract FiatOnrampScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // address verifier = address(0xAe94FB09711e1c6B057853a515483792d8e474d0); // reclaim verifier
        StubVerifier verifier = new StubVerifier();
        FiatOnramp fiatOnramp = new FiatOnramp(address(verifier));
        console.logAddress(address(fiatOnramp));

        vm.stopBroadcast();
    }
}
