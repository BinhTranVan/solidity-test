// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // Events for custom logging
    event TokensBurned(address indexed burner, uint256 value);
    event AllowanceSet(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Burns a specific amount of tokens.
     * Only callable by the contract owner.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    /**
     * @dev Sets an allowance for another account to spend tokens on behalf of the caller.
     */
    function setAllowance(address spender, uint256 amount) public {
        _approve(msg.sender, spender, amount);
        emit AllowanceSet(msg.sender, spender, amount);
    }

    /**
     * @dev Transfers tokens from one address to another.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        bool result = super.transferFrom(sender, recipient, amount);
        emit Transfer(sender, recipient, amount);
        return result;
    }
}
