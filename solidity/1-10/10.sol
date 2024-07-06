// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/utils/Strings.sol";

/*
   숫자만 들어가는 array numbers를 선언하고 숫자를 넣고(push), 빼고(pop), 
   특정 n번째 요소의 값을 볼 수 있는(get)함수를 구현하세요.
*/

contract NumberArray {
    uint[] numbers;
    function push(uint num) public {
        numbers.push(num);
    }
    function pop() public {
        numbers.pop();
    }
    function get(uint index) public view returns(uint) {
        return numbers[index];
    }
}