// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {CounterV4} from "@src/CounterV4.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Safe} from "@safe-utils/Safe.sol";

contract ProposeSafeTxUpgradeCounterV4WithLedgerScript is Script {
    using Safe for *;

    Safe.Client safe;
    address counter;
    address signer;
    string derivationPath;

    function setUp() public {
        safe.initialize(vm.envAddress("SAFE_ADDRESS"));
        counter = vm.envAddress("COUNTER_ADDRESS");
        signer = vm.envAddress("SIGNER_ADDRESS");
        derivationPath = vm.envString("DERIVATION_PATH");
    }

    function run() public {
        vm.startBroadcast();

        CounterV4 v4 = new CounterV4();

        vm.stopBroadcast();

        safe.proposeTransaction(
            address(counter),
            abi.encodeCall(UUPSUpgradeable.upgradeToAndCall, (address(v4), abi.encodeCall(CounterV4.reinitialize, (3)))),
            signer,
            derivationPath
        );
    }
}
