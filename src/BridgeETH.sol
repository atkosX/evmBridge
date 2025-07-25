// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {console} from "forge-std/console.sol";

contract BridgeETH is Ownable {

    uint256 public balance;
    address public tokenAddress;

    event Deposit(address indexed user, uint256 amount);
    mapping (address=>uint256) public pendingBalances;


    constructor(address _BAdvanceAddress) {
        tokenAddress = _BAdvanceAddress;
    }

    function deposit( IERC20 _tokenAddress,uint256 amount) public payable {
        require(address(_tokenAddress) ==tokenAddress, "Token address not set");
        require(_tokenAddress.allowance(msg.sender, address(this)) >= amount, "Insufficient allowance");
        _tokenAddress.transferFrom(msg.sender, address(this), amount);
        pendingBalances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw (IERC20 _tokenAddress, uint256 amount) public {
        require(address(_tokenAddress) ==tokenAddress, "Token address not set");
        require(pendingBalances[msg.sender] >= amount, "Insufficient balance");
        pendingBalances[msg.sender] -= amount;
        _tokenAddress.transfer(msg.sender, amount);
    }

    function burnedOnOtherChain(address userAccount, uint256 amount) public onlyOwner {
        pendingBalances[userAccount] += amount;
    }

}
