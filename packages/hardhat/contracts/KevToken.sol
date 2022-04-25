// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <=0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KevToken is Ownable, ERC20("Trader Kev", "KEV") {

    uint constant MAX_TOTAL_SUPPLY_TOKEN = 1e9;

    /**
    @notice Allow mint more token, but not exceed the max total supply token
    */
    function mint(address _to, uint _amount) public onlyOwner {
        // Checking amount is minted not exceed total tokens
        require(
            totalSupply() + _amount <= MAX_TOTAL_SUPPLY_TOKEN,
            "The amount not exceed maximum total supply token"
        );
        _mint(_to, _amount);
    }
}