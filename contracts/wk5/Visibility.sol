// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// ref: https://www.youtube.com/watch?v=f4sD6F-OhMY

// Visibility
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside the contract
// external - only from outside contract

/*
Contract A
  private  pri()
  internal inter()
  public   pub()
  external ext()

Contract B is A
  internal inter()
  public   pub()

Contract C (C can call pub() and ext() from both A and B)
  public   pub()
  external ext()
*/

contract VisibilityBase {
    uint private  x = 0;
    uint internal y = 1;
    uint public   z = 2;

    function privateFunc() private pure returns(uint) {
        return 0;
    }

    function internalFunc() internal pure returns(uint) {
        return 100;
    }

    function publicFunc() public pure returns(uint) {
        return 200;
    }

    function externalFunc() external pure returns(uint) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();

        // externalFunc();      // Not able to compile when calling external function. 
        // this.externalFunc(); // Although we can make an external call by using "this" but gas inefficient.
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;             // x cannot be called since it's private
        // privateFunc();  // privateFunc cannot be called since it's private
        internalFunc();
        publicFunc();

        // externalFunc(); // Also not able to be called
    }
}