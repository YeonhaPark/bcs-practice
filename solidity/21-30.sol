// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
 * 3의 배수만 들어갈 수 있는 array를 구현하세요.
 */
contract TEST21 {
    uint[] array;
    function addElement(uint num) public {
        require(num % 3 == 0, "Value must be a multiple of 3");
        array.push(num);
    }
    function getArray() public view returns(uint[] memory) {
        return array;
    }
}
/**
 * 뺄셈 함수를 구현하세요. 임의의 두 숫자를 넣으면 자동으로 둘 중 큰수로부터 작은 수를 빼는 함수를 구현하세요.
 *   예) 2,5 input → 5-2=3(output)
 */
contract TEST22 {
    function subtract(uint a, uint b) public pure returns(uint) {
        if (a > b) {
            return a - b;
        } else if (a < b) {
            return b - a;
        } else {
            return 0;
        }
    }
}
/**
 * 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
 */
contract TEST23 {
    function calculate(uint num) public pure returns(string memory) {
        if (num % 3 == 0) {
            return "A";
        } else if (num % 3 == 1) {
            return "B";
        } else {
            return "C";
        }
    }
}
/**
 * string을 input으로 받는 함수를 구현하세요. “Alice”가 들어왔을 때에만 true를 반환하세요.
 */
contract TEST24 {
    function isAlice(string memory name) public pure returns(bool) {
        return keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked('Alice')) ? true : false;
    }

}

/**
 * 배열 A를 선언하고 해당 배열에 n부터 0까지 자동으로 넣는 함수를 구현하세요. 
 */

contract TEST25 {
    uint[] A;

    function makeA(uint n) public {
        uint i = 0;
        while (i <= n) {
            A.push(i);
            i++;
        }
    }
}
/**
 * 홀수만 들어가는 array, 짝수만 들어가는 array를 구현하고 숫자를 넣었을 때 자동으로 홀,짝을 나누어 입력시키는 함수를 구현하세요. 
 */
   
contract TEST26 {
    uint[] evens;
    uint[] odds;

    function pushNum(uint n) public {
        if (n % 2 == 0) {
            evens.push(n);
        } else {
            odds.push(n);
        }
    }

}

/**
 * string 과 bytes32를 key-value 쌍으로 묶어주는 mapping을 구현하세요. 해당 mapping에 정보를 넣고, 지우고 불러오는 함수도 같이 구현하세요.
 */

contract TEST27 {
    mapping(string => bytes32) bytesByString;

    function getMap(string memory str) public view returns(bytes32) {
        return bytesByString[str];
    }

    function addMap(string memory k, bytes32 v) public {
        bytesByString[k] = v;
    }

    function deleteMap(string memory k) public {
        bytesByString[k] = 0;
    }
}
/**
 * ID와 PW를 넣으면 해시함수(keccak256)에 둘을 같이 해시값을 반환해주는 함수를 구현하세요.
 */

contract TEST28 {
     function generateHash(string memory _id, string memory _password) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_id, _password));
    }
}
/**
 * 숫자형 변수 a와 문자형 변수 b를 각각 10 그리고 “A”의 값으로 배포 직후 설정하는 contract를 구현하세요.
 */

contract TEST29 {
    uint a;
    string b;
    constructor(uint _a, string memory _b) {
        a = _a;
        b = _b;
    }
}

/**
 * 임의대로 숫자를 넣으면 알아서 내림차순으로 정렬해주는 함수를 구현하세요
 * (sorting 코드 응용 → 약간 까다로움)
 *    예 : [2,6,7,4,5,1,9] → [9,7,6,5,4,2,1]
 */

contract TEST30 {
    function pushNum(uint[] memory arr) public pure returns(uint[] memory){
        if (arr.length == 0) {
           return arr;
        } else {
            for (uint i = 0; i < arr.length; i++) {
                for (uint j = i + 1; j < arr.length; j++) {
                    if (arr[i] < arr[j]) {
                        (arr[i], arr[j]) = (arr[j], arr[i]);
                    }
                }
            }
            return arr;
        }
    }
}
