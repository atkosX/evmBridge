// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BAdvance is ERC20 {
    
    address private BAdvanceAddress;

    constructor() ERC20("BAdvance", "BADV") Ownable(msg.sender) {
        BAdvanceAddress = msg.sender; // Set the initial owner to the deployer
       
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public onlyOwner {
        _burn(msg.sender, amount);
    }


}