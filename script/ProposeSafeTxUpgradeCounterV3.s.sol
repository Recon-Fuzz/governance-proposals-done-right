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
    address foundrySigner1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    bytes32 foundrySigner1PrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    // NOTE: this method is not recommended, please refer to the `ProposeSafeTxUpgradeCounterV4WithLedger.s.sol` script for a better approach

    function setUp() public {
        safe.initialize(vm.envAddress("SAFE_ADDRESS"));
        counter = vm.envAddress("COUNTER_ADDRESS");
    }

    function run() public {
        vm.startBroadcast();

        CounterV3 v3 = new CounterV3();

        vm.stopBroadcast();

        vm.rememberKey(uint256(foundrySigner1PrivateKey));
        safe.proposeTransaction(
            address(counter),
            abi.encodeCall(UUPSUpgradeable.upgradeToAndCall, (address(v3), abi.encodeCall(CounterV3.reinitialize, (2)))),
            foundrySigner1
        );
    }
}
