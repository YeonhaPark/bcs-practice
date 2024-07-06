// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
    더하기, 빼기, 곱하기, 나누기 그리고 제곱을 반환받는 계산기를 만드세요.
*/

contract Calculator {
    uint public a;
    function setA(uint _a) public {
        a = _a;
    }

    function add(uint num) public returns(uint) {
        a = a + num;
        return a + num;
    }
    function mul(uint num) public returns(uint) {
        a = a * num;
        return a * num;
    }
    function div(uint num) public returns(uint) {
        a = a / num;
        return a / num;
    }
    function pow(uint num) public returns(uint) {
        a = a ** num;
        return a ** num;
    }
}