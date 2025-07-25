// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Contract.sol";

contract TestContract is Test {
    Contract c;

    function setUp() public {
        c = new Contract(1);
    }

    function testInc() public {
        assertEq(c.getnum(), 1, "ok");
        c.increment();
        assertEq(c.getnum(), 2, "ok");
    }

    function testDec() public {
        assertEq(c.getnum(), 1, "ok");
        c.decrement();
        assertEq(c.getnum(), 0, "ok");
    }
}
