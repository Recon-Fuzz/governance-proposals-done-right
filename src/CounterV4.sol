// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Ownable2StepUpgradeable} from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

contract CounterV4 is UUPSUpgradeable, Ownable2StepUpgradeable {
    uint256 public number;
    uint256 public multiplier;
    uint256 public divider;

    constructor() {
        _disableInitializers();
    }

    function initialize(address _owner, uint256 _number, uint256 _multiplier, uint256 _divider) public initializer {
        __UUPSUpgradeable_init();
        __Ownable2Step_init();
        __Ownable_init(_owner);

        setNumber(_number);
        setMultiplier(_multiplier);
        setDivider(_divider);
    }

    function reinitialize(uint256 _divider) public reinitializer(4) {
        setDivider(_divider);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function setMultiplier(uint256 newMultiplier) public {
        multiplier = newMultiplier;
    }

    function setDivider(uint256 newDivider) public {
        divider = newDivider;
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        number--;
    }

    function multiply() public {
        number *= multiplier;
    }

    function divide() public {
        number /= divider;
    }
}
