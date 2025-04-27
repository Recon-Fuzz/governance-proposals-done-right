// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CounterV2} from "@src/CounterV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterV2Script is Script {
    CounterV2 public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new CounterV2();

        vm.stopBroadcast();
    }
}
