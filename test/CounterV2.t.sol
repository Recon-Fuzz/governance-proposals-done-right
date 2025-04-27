// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "@src/Counter.sol";
import {CounterV2} from "@src/CounterV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterV2Test is Test {
    Counter public v1;

    function setUp() public {
        v1 = Counter(
            address(new ERC1967Proxy(address(new Counter()), abi.encodeCall(Counter.initialize, (address(this)))))
        );
    }

    function test_Upgrade() public returns (CounterV2) {
        v1.upgradeToAndCall(address(new CounterV2()), abi.encodeCall(CounterV2.reinitialize, (42)));
        return CounterV2(address(v1));
    }

    function test_Increment() public {
        CounterV2 v2 = test_Upgrade();
        v2.increment();
        assertEq(v2.number(), 43);
    }

    function testFuzz_SetNumber(uint256 x) public {
        CounterV2 v2 = test_Upgrade();
        v2.setNumber(x);
        assertEq(v2.number(), x);
    }

    function test_Decrement() public {
        CounterV2 v2 = test_Upgrade();
        v2.decrement();
        assertEq(v2.number(), 41);
    }
}
