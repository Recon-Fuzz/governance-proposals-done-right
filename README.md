## governance-proposals-done-right

https://discord.com/events/1199312177727799336/1364279534425211031

In this Office Hours, Antonio Viggiano will go through Safe Utils and Tenderly Utils, two Foundry SDKs that can be used to schedule, validate, simulate, and execute Multisig transactions. This framework helps put security researchers closer to developers in the process of submitting governance proposal to DAOs and DeFi protocols.

## Demo

### 1. Create a Safe through the Safe UI

![Safe UI](assets/safe-ui.png)

### 1. Deploy a `Counter` UUPSUpgradeable proxy contract with your Safe as owner

```bash
forge script script/Counter.s.so --rpc-url base -vvvv --account $ACCOUNT --broadcast --verify
```

### 2. Go on Basescan and see you can correctly write/read from the contract

![Basescan UI](assets/basescan-ui.png)

[increment tx](https://basescan.org/tx/0x8a22852c6f8175e20ce573b616b1f012fa7ca5c19be16e925eb5f266c7ccecd1)

### 3. Upgrade to `CounterV2` through a Foundry deployment + Safe UI upgrade

TODO