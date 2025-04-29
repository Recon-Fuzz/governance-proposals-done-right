// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "@src/Counter.sol";
import {CounterV3} from "@src/CounterV3.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract CounterV3Test is Test {
    Counter public v1;

    function setUp() public {
        v1 = Counter(
            address(new ERC1967Proxy(address(new Counter()), abi.encodeCall(Counter.initialize, (address(this)))))
        );
    }

    function test_Upgrade() public returns (CounterV3) {
        v1.upgradeToAndCall(address(new CounterV3()), abi.encodeCall(CounterV3.reinitialize, (2)));
        return CounterV3(address(v1));
    }

    function test_Increment() public {
        CounterV3 v3 = test_Upgrade();
        v3.increment();
        assertEq(v3.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        CounterV3 v3 = test_Upgrade();
        v3.setNumber(x);
        assertEq(v3.number(), x);
    }

    function test_Multiply() public {
        CounterV3 v3 = test_Upgrade();
        v3.increment();
        v3.increment();
        assertEq(v3.number(), 2);
        v3.multiply();
        assertEq(v3.number(), 4);
    }
}
