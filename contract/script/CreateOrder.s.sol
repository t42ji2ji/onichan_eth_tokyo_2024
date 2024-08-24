// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {FiatOnramp} from "../src/FiatOnramp.sol";
import {USDT} from "../src/USDT.sol";
import {USDC} from "../src/USDC.sol";
import "forge-std/console.sol";

contract CreateOrderScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        FiatOnramp fiatOnramp = FiatOnramp(
            payable(0xD570bF4598D3ccF214E288dd92222b8Bd3134984)
        );
        USDT usdt = USDT(0xB06c44B2601AB296269dDC081492B266C49C6949);
        USDC usdc = USDC(0x7356f4cC77168d0e6f94F1d8E28aeA1316852c0d);

        usdt.approve(address(fiatOnramp), 1000000000000000000);
        usdc.approve(address(fiatOnramp), 1000000000000000000);

        fiatOnramp.createOrder(address(usdt), 150000000, 1);
        fiatOnramp.createOrder(address(usdc), 100000000, 2);
        fiatOnramp.createOrder(address(usdc), 200000000, 3);

        vm.stopBroadcast();
    }
}
