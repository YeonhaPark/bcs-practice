// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/*
숫자를 넣었을 때 그 숫자의 자릿수와 각 자릿수의 숫자를 나열한 결과를 반환하세요.
예) 2 -> 1,   2 // 45 -> 2,   4,5 // 539 -> 3,   5,3,9 // 28712 -> 5,   2,8,7,1,2
--------------------------------------------------------------------------------------------
문자열을 넣었을 때 그 문자열의 자릿수와 문자열을 한 글자씩 분리한 결과를 반환하세요.
예) abde -> 4,   a,b,d,e // fkeadf -> 6,   f,k,e,a,d,f
*/

contract TEST6 {
    function num(uint n) public pure returns(uint, uint[] memory){
        uint leng = 1;
        if (n < 10) {
            uint[] memory arr = new uint[](1);
            arr[0] = n;
            return (1, arr);
        } else {
            while(n != 0) {
                n = n / 10;
                leng++;
            }
            uint[] memory arr = new uint[](leng);
            for (uint i = leng - 1; i >= 0; i--) { 
            uint digit = n % 10;
            n = (n / 10);
            arr[i] = digit;
            }
            return (leng, arr);
        }
    }

      function getStringLength(string memory s) public pure returns (uint) {
        return bytes(s).length;
    }

    function str(string memory s) public pure returns(uint, string[] memory){
        bytes memory stringBytes = bytes(s);
        string[] memory result = new string[](stringBytes.length);

        for (uint i = 0; i < stringBytes.length; i++) {
            bytes memory char = new bytes(1);
            char[0] = stringBytes[i];
            result[i] = string(char);
        }

        return (bytes(s).length, result);
        }
}

