// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./VestingLogic.sol";

contract VestingFactory is Ownable {
    address public immutable implementation;
    address[] public allVestingWallets;

    event VaultCreated(address indexed proxy, address indexed beneficiary);

    constructor(address _implementation) Ownable(msg.sender) {
        implementation = _implementation;
    }

    function deployVesting(
        address _token,
        address _beneficiary,
        uint256 _start,
        uint256 _duration
    ) external onlyOwner returns (address) {
        address proxy = Clones.clone(implementation);
        VestingLogic(proxy).initialize(_token, _beneficiary, _start, _duration);
        
        allVestingWallets.push(proxy);
        emit VaultCreated(proxy, _beneficiary);
        return proxy;
    }

    function getVaultCount() external view returns (uint256) {
        return allVestingWallets.length;
    }
}
