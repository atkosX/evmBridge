// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LockUSTD{

    address private ustdAddress;

    constructor(address _ustdAddress) {
        ustdAddress = _ustdAddress; 
        
    }

    function deposit(uint256 _amount) public payable{
       require(IERC20(ustdAddress).allowance(msg.sender, address(this)) >= _amount, "Insufficient allowance");
       IERC20(ustdAddress).transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint256 amount) public{
    }
}