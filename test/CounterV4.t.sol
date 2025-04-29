// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "@src/Counter.sol";
import {CounterV4} from "@src/CounterV4.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterV4Test is Test {
    Counter public v1;

    function setUp() public {
        v1 = Counter(
            address(new ERC1967Proxy(address(new Counter()), abi.encodeCall(Counter.initialize, (address(this)))))
        );
    }

    function test_Upgrade() public returns (CounterV4) {
        v1.upgradeToAndCall(address(new CounterV4()), abi.encodeCall(CounterV4.reinitialize, (3)));
        return CounterV4(address(v1));
    }

    function test_Increment() public {
        CounterV4 v4 = test_Upgrade();
        v4.increment();
        assertEq(v4.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        CounterV4 v4 = test_Upgrade();
        v4.setNumber(x);
        assertEq(v4.number(), x);
    }

    function test_Multiply() public {
        CounterV4 v4 = test_Upgrade();
        v4.increment();
        v4.increment();
        assertEq(v4.number(), 2);
        v4.multiply();
        assertEq(v4.number(), 0);
    }

    function test_Divide() public {
        CounterV4 v4 = test_Upgrade();
        v4.increment();
        assertEq(v4.number(), 1);
        v4.divide();
        assertEq(v4.number(), 0);
        v4.increment();
        v4.increment();
        v4.increment();
        assertEq(v4.number(), 3);
        v4.divide();
        assertEq(v4.number(), 1);
    }
}
