// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
// 가능한 모든 것을 inline assembly로 진행하시면 됩니다.
// 1. 숫자들이 들어가는 동적 array number를 만들고 1~n까지 들어가는 함수를 만드세요.

// 5. number의 k번째 요소를 반환하는 함수를 구현하세요.
// 6. number의 k번째 요소를 반환하는 함수를 구현하세요.

contract InlineAssembly {
        //     uint[4] memory numbers;

        // assembly {
        //     mstore(numbers,16)
        //     mstore(add(numbers,0x20),32)
        //     mstore(add(numbers,0x40),48)
        //     mstore(add(numbers,0x60),64)
        // }

        // return numbers;
    function makeArray(uint n) public pure returns (uint[] memory) {
        uint[] memory numbers = new uint[](n);
        assembly {
            let start := add(numbers, 0x20)
            let i := 0
            for {} lt(i, add(n, 1)) { i := add(i, 1)} {
                mstore(add(start, mul(0x20,i)), add(i, 1))
            }
            
        }
        return numbers;
    }

    // 2. 숫자들이 들어가는 길이 4의 array number2를 만들고 여기에 4개의 숫자를 넣어주는 함수를 만드세요.
    function makeArray2(uint a, uint b, uint c, uint d) public pure returns(uint[4] memory) {
        uint[4] memory numbers;
        assembly {
            mstore(numbers, a)
            mstore(add(numbers, 0x20), b)
            mstore(add(numbers, 0x40), c)
            mstore(add(numbers, 0x60), d)
        }
        return numbers;
    }
    // 3. number의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
    function makeArraySum(uint[] memory numbers) public pure returns(uint result) {
        uint length = numbers.length;
        assembly {
            let tempResult := 0
            let i := 0
            let len := length
            for {} lt(i, len) { i:= add(i, 1)} {
                let value := mload(add(numbers, mul(0x20, i)))
                tempResult := add(tempResult, value)
            }
            result := tempResult
        }
    }
    // 4. number2의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
    function makeArray2Sum(uint[4] memory numbers) public pure returns(uint result) {
        assembly {
            result := 0
            let i := 0
            let len := 4
            let ptr := add(numbers, 0x20)
            for {} lt(i, len) { i:= add(i, 1)} {
                result := add(result, mload(ptr))
                ptr := add(ptr, 0x20)
            }
        }
    }
}
