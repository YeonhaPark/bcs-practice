// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/utils/Strings.sol";

/*
    아래의 함수를 만드세요
    1~10을 입력하면 “A” 반환받습니다.
    11~20을 입력하면 “B” 반환받습니다.
    21~30을 입력하면 “C” 반환받습니다.
*/

contract ReturnGrade {
    function getGrade(uint num) public pure returns(string memory){
         require(num >= 1 && num <= 30, "The number is out of range");
        if (num >= 1 && num <= 10) {
            return 'A';
        } else if (num >= 11 && num <= 20) {
            return 'B';
        } else if (num >= 21 && num <= 30) {
            return 'C';
        }
         revert("Unreachable code");
    }
}

