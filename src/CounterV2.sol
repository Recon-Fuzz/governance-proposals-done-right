// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Ownable2StepUpgradeable} from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

contract CounterV2 is UUPSUpgradeable, Ownable2StepUpgradeable {
    uint256 public number;

    constructor() {
        _disableInitializers();
    }

    function initialize(address _owner, uint256 _number) public initializer {
        __UUPSUpgradeable_init();
        __Ownable2Step_init();
        __Ownable_init(_owner);

        setNumber(_number);
    }

    function reinitialize(uint256 _number) public reinitializer(2) {
        setNumber(_number);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        number--;
    }
}
