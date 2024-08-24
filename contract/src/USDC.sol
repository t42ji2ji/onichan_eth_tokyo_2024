// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract USDC is ERC20, Ownable {
    constructor() ERC20("Circle USD", "USDC") Ownable(msg.sender) {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 6; // USDT typically uses 6 decimal places
    }
}
