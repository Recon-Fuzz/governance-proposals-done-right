// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {CounterV3} from "@src/CounterV3.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Safe} from "@safe-utils/Safe.sol";

contract ProposeSafeTxUpgradeCounterV3Script is Script {
    using Safe for *;

    Safe.Client safe;
    address counter;
    address signer;

    function setUp() public {
        safe.initialize(vm.envAddress("SAFE_ADDRESS"));
        counter = vm.envAddress("COUNTER_ADDRESS");
        signer = vm.envAddress("SIGNER_ADDRESS");
    }

    function run() public {
        vm.startBroadcast();

        CounterV3 v3 = new CounterV3();

        vm.stopBroadcast();

        safe.proposeTransaction(
            address(counter),
            abi.encodeCall(UUPSUpgradeable.upgradeToAndCall, (address(v3), abi.encodeCall(CounterV3.reinitialize, (2)))),
            signer
        );
    }
}
