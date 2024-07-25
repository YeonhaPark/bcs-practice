// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
 흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 
등의 조건이 붙는 경우가 있습니다. 그러한 조건을 구현하세요.

입력값을 받으면 그 입력값 안에 대문자, 
소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 여부를 
알려주는 함수를 구현하세요. 
 */

contract Password {
    function checkPassword(string memory pw) public pure returns(bool) {
        bytes memory pwBytes = bytes(pw);
        bool capitalLetter;
        bool smallLetter;
        bool number;
        for (uint i = 0; i < pwBytes.length; i++) {
            bytes1 target = pwBytes[i];
            if (target >= 0x30 && target <= 0x39) {
                number = true;
            } else if (target >= 0x41 && target <= 0x5A) {
                capitalLetter = true;
            } else if (target >= 0x61 && target <= 0x7A) {
                smallLetter = true;
            }
            
        }
        return number && capitalLetter && smallLetter; // 12Aa -> 0x31324161 // ascii 30~39 : 숫자, 41 ~ 5A: 대문자, 61 ~ 7A: 소문자 

    }
}