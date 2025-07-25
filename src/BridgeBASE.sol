// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {console} from "forge-std/console.sol";

interface IBAdvance{
    function mint(address to, uint256 amount) external;
    function burn(address from, uint256 amount) external;
}

contract BridgeBASE is Ownable{
    address public tokenAddress;

    event Burn(address indexed user, uint256 amount);
    mapping (address => uint256) public pendingBalances;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function burn(IBAdvance _tokenAddress, uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(pendingBalances[msg.sender] >= amount, "Insufficient balance to burn");
        _tokenAddress.burn(msg.sender,amount);
        emit Burn(msg.sender, amount);
    }


    function withdraw(IBAdvance _tokenAddress, uint256 amount) public {
        require(address(_tokenAddress) == tokenAddress, "Token address not set");
        require(amount > 0, "Amount must be greater than zero");
        require(pendingBalances[msg.sender] >= amount, "Insufficient balance");
        pendingBalances[msg.sender] -= amount;
        _tokenAddress.mint(msg.sender, amount);
    }



    function depositOnOtherChain(address userAccount,uint256 amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        pendingBalances[userAccount] += amount;
    }

}
