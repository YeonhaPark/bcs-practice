// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract Bytes {
    function getLength(string memory s) public pure returns (uint){
        return bytes(s).length;
    }
}