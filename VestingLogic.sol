// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VestingLogic is Initializable {
    IERC20 public token;
    address public beneficiary;
    uint256 public start;
    uint256 public duration;
    uint256 public released;

    // Use initializer instead of constructor for proxies
    function initialize(
        address _token,
        address _beneficiary,
        uint256 _start,
        uint256 _duration
    ) external initializer {
        token = IERC20(_token);
        beneficiary = _beneficiary;
        start = _start;
        duration = _duration;
    }

    function vestedAmount() public view returns (uint256) {
        uint256 totalBalance = token.balanceOf(address(this)) + released;
        if (block.timestamp < start) return 0;
        if (block.timestamp >= start + duration) return totalBalance;
        return (totalBalance * (block.timestamp - start)) / duration;
    }

    function release() external {
        uint256 amount = vestedAmount() - released;
        require(amount > 0, "Nothing to release");
        released += amount;
        token.transfer(beneficiary, amount);
    }
}
