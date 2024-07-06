// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/*
    숫자만 들어갈 수 있는 array numbers를 만들고 
    그 array안에 0부터 9까지 자동으로 채우는 함수를 구현하세요.(for 문)
*/

contract NumberLoop {
    uint[10] numbers;
    function fillToNine() public {
        for (uint i = 0; i < 10; i++) {
            numbers[i] = i;
        }
    }

    function getNumbers() public view returns(uint[10] memory) {
        return numbers;
    }
}