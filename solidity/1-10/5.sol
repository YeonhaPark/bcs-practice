// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/*
    아래의 함수를 만드세요
    1~3을 입력하면 입력한 수의 제곱을 반환받습니다.
    4~6을 입력하면 입력한 수의 2배를 반환받습니다.
    7~9를 입력하면 입력한 수를 3으로 나눈 나머지를 반환받습니다.
*/

contract Numbers {
    function oneToThree(uint num) public pure returns(uint){
        return num ** 2;
    }
    function fourToSix(uint num) public pure returns(uint){
        return num * 2;
    }
    function sevenToNine(uint num) public pure returns(uint){
        return num % 3;
    }
}
