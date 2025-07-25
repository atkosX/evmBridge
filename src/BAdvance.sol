// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BAdvance is ERC20 {
    
    address private BAdvanceAddress;

    constructor() ERC20("BAdvance", "BADV") Ownable(msg.sender) {
        
       
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}