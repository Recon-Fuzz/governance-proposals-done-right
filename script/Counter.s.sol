// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "@src/Counter.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterScript is Script {
    Counter public counter;
    address public owner;

    function setUp() public {
        owner = vm.envAddress("SAFE_ADDRESS");
    }

    function run() public {
        vm.startBroadcast();

        counter =
            Counter(address(new ERC1967Proxy(address(new Counter()), abi.encodeCall(Counter.initialize, (owner)))));

        vm.stopBroadcast();
    }
}
