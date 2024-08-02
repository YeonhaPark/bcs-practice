// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
// import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

/**
 * 배열에서 특정 요소를 없애는 함수를 구현하세요. 
 * 예) [4,3,2,1,8] 3번째를 없애고 싶음 → [4,3,1,8]
 */
contract TEST91 {
    function slice(uint[] memory nums, uint index) public pure returns(uint[] memory){
        uint[] memory newNums = new uint[](nums.length - 1);
        uint j = 0;
        for (uint i = 0; i < nums.length; i++) {
            if (i != index) {
                newNums[j] = nums[i]; // i 는 계속 올라감. 
                j++;
            }
        }
        return newNums;
    }
}
/**
 * 특정 주소를 받았을 때, 그 주소가 EOA인지 CA인지 감지하는 함수를 구현하세요.
 */
contract TEST92 {
    // eoa, ca 차이.
    function distinguish(address addr) public view returns(string memory) {
        uint32 size;
        assembly {
            size := extcodesize(addr)
        }
        if (size > 0) {
            return "Contract Account";
        } else {
            return "Externally Owned Account";
        }
    }
}
/**
 * 다른 컨트랙트의 함수를 사용해보려고 하는데, 
 * 그 함수의 이름은 모르고 methodId로 추정되는 값은 있다. 
 * input 값도 uint256 1개, address 1개로 추정될 때 해당 함수를 활용하는 함수를 구현하세요.
 */

contract TEST93 {
    function useFunc(address ca, string memory methodId, uint a, address addr) public {
        string memory other = "(uint256,address)";
        (bool success, ) = ca.call(abi.encodeWithSignature(string(abi.encodePacked(methodId, other)), a, addr));
        require(success);
    }
}

/**
 * inline - 더하기, 빼기, 곱하기, 나누기하는 함수를 구현하세요.
 */

 contract TEST94 {
    function add(uint a, uint b) public  pure returns(uint data){
        assembly {
            data := add(a, b)
        }
    }
    function sub(uint a, uint b) public  pure returns(uint data){
        assembly {
            data := sub(a, b)
        }
    }
    function mul(uint a, uint b) public  pure returns(uint data){
        assembly {
            data := mul(a, b)
        }
    }
    function div(uint a, uint b) public  pure returns(uint data){
        assembly {
            data := div(a, b)
        }
    }
 }
/**
 * inline - 3개의 값을 받아서, 더하기, 곱하기한 결과를 반환하는 함수를 구현하세요.
 */
 contract TEST95 {
     function add(uint a, uint b, uint c) public  pure returns(uint data){
        assembly {
            let ing := add(a, b)
            data := add(ing, c)
        }
    }
    function sub(uint a, uint b, uint c) public  pure returns(uint data){
        assembly {
            let ing := sub(a, b)
            data := sub(ing, c)
        }
    }
    function mul(uint a, uint b, uint c) public  pure returns(uint data){
        assembly {
            let ing := mul(a, b)
            data := mul(ing, c)
        }
    }
    function div(uint a, uint b, uint c) public  pure returns(uint data){
        assembly {
            let ing := div(a, b)
            data := div(ing, c)
        }
    }
 }

/**
 * inline - 4개의 숫자를 받아서 가장 큰수와 작은 수를 반환하는 함수를 구현하세요.
 */
 contract TEST96 {
    function extreme(uint[] memory a) public pure returns(uint, uint) {
        assembly {
            let smallest := mload(add(a, 0x20))
            let biggest :=  mload(add(a, 0x20))
            for { let i := 1 } lt(i, 4) { i := add(i, 1) } {
                let current := mload(add(a, mul(add(i, 1), 0x20)))
                if lt(current, smallest) { smallest := current }
                if gt(current, biggest) { biggest := current }
            }
            mstore(0x40, smallest)
            mstore(0x60, biggest)
            return(0x40, 0x60)
        }
    }
 }
/**
 * inline - 상태변수 숫자만 들어가는 동적 array numbers에 push하고 pop하는 함수 그리고 전체를 반환하는 구현하세요.
 */
 contract TEST97 {
    uint[] array;
    function push(uint n) public  {
        assembly {
            let slot := array.slot

            // array의 길이를 가져옵니다.
            let length := sload(slot)

            // 새로운 요소가 저장될 위치를 계산합니다.
            let elementPosition := add(keccak256(slot, 0x20), length)

            // 새로운 값을 저장합니다.
            sstore(elementPosition, n)

            // array의 길이를 1 증가시킵니다.
            sstore(slot, add(length, 1))
        }
    }
    function pop() public {
        assembly {
            let slot := array.slot

            // array의 길이를 가져옵니다.
            let length := sload(slot)

            // array의 길이를 1 증가시킵니다.
            sstore(slot, sub(length, 1))
        }
    }
    function getArray() public view returns(uint[] memory){
       return array;
    }
 }
/**
 * inline - 상태변수 문자형 letter에 값을 넣는 함수 setLetter를 구현하세요..
 */

 contract TEST98 {
    string letter;
    function setLetter(string memory _letter) public {
        assembly {
            let slot := sload(letter.slot)

            let length := mload(_letter)

            sstore(slot, length) // .. 잘 이해 안됨

            let data := add(_letter, 0x20)

            sstore(add(slot, 1), mload(data))
        }
    }
 }
/**
 * nline - bytes4형 b의 값을 정하는 함수 setB를 구현하세요.
 */
contract TEST99 {
    bytes4 public b;
    function setB(bytes4 _b) public {
        assembly {
            let slot := sload(b.slot) 
            sstore(slot, _b)
        }
    }
}
/**
 * - 
1. inline - bytes형 변수 b의 값을 정하는 함수 setB를 구현하세요.
 */

 contract TEST100 {
    bytes public b;
        function setB(bytes memory _b) public {
        assembly {
            let slot := sload(b.slot) 
            sstore(slot, _b)
            let elementPosition := keccak256(slot, 0x20)
            sstore(elementPosition, mload(_b))
            let data := add(_b, 0x20)
            let len := mload(_b)
            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                sstore(add(slot, i), mload(add(data, mul(i, 0x20))))
            }
        }
    }
 }