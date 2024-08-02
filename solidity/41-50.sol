// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

/**
 * 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고 
 * 그 배열에 숫자를 넣는 함수를 구현하세요. 
 * 배열을 초기화하는 함수도 구현하세요. 
 * (길이가 4가 되면 자동으로 초기화하는 기능은 굳이 구현하지 않아도 됩니다.)
 */


contract TEST41 {
    uint[4] nums;
    function pushNum(uint[4] memory _nums) public {
        for (uint i = 0; i < _nums.length; i++) {
            nums[i] = _nums[i];
        }
    }

    function resetNums() public {
        nums = [0,0,0,0];
    }
}

/**
 * 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요.  
 * 새로운 고객 정보를 만들 수 있는 함수도 구현하되 이름의 글자가 최소 5글자가 되게 설정하세요.
 */

contract TEST42 {
    struct Customer {
        string name;
        uint number;
        address addr;
    }

    mapping(address => Customer) customer;
    function setNewCustomer(string memory _name, uint _number, address _addr) public {
        require(bytes(_name).length > 5, "name must be longer than 4 letters");
        customer[_addr] = Customer(_name, _number, _addr);
    }
}
/**
 * 은행의 역할을 하는 contract를 만드려고 합니다. 
 * 별도의 고객 등록 과정은 없습니다. 
 * 해당 contract에 ether를 예치할 수 있는 기능을 만드세요. 
 * 또한, 자신이 현재 얼마를 예치했는지도 볼 수 있는 함수 그리고 자신이 예치한만큼의 ether를 인출할 수 있는 기능을 구현하세요.
 * 힌트 : mapping을 꼭 이용하세요.
 */

contract TEST43 {
    mapping(address => uint) balance;
    function deposit() public payable {
    }

    function checkBalance() public view returns(uint) {
        return balance[msg.sender];
    }
    function withdraw() public {
        payable(msg.sender).transfer(balance[msg.sender]);
    }
}

/**
 * string만 들어가는 array를 만들되, 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.
 */
contract TEST44{
    string[]  array;
    function makeArray(string memory str) public {
        require(bytes(str).length > 3, "More than three letters only");
        array.push(str);
    }
}
/**
 * 숫자만 들어가는 array를 만들되, 100이하의 숫자만 들어갈 수 있게 구현하세요.
 */
contract TEST45 {
    uint[] array;
    function onlyTilHundred(uint num) public {
        require(num <= 100, 'Only until one hundred');
        array.push(num);
    }
}
/**
 * 3의 배수이거나 10의 배수이면서 50보다 작은 수만 들어갈 수 있는 array를 구현하세요.
 * (예 : 15 -> 가능, 3의 배수 // 40 -> 가능, 
 * 10의 배수이면서 50보다 작음 // 66 -> 가능, 
 * 3의 배수 // 70 -> 불가능 10의 배수이지만 50보다 큼)
 */
contract TEST46 {
    uint[] arr;
    function pushArr(uint num) public {
        require(num < 50 && (num % 3 == 0 || num % 10 == 0), "condition not satisfied");
        arr.push(num);
    }

    function getArr() public view returns(uint[] memory) {
        return arr;
    }
}
/**
 * 배포와 함께 배포자가 owner로 설정되게 하세요. 
 * owner를 바꿀 수 있는 함수도 구현하되 그 함수는 owner만 실행할 수 있게 해주세요.
 */
contract TEST47 {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "sender is not owner");
        owner = newOwner;
    }
}
/**
 * A라는 contract에는 2개의 숫자를 더해주는 함수를 구현하세요. 
 *  B라고 하는 contract를 따로 만든 후에 A의 더하기 함수를 사용하는 코드를 구현하세요.
 */
contract A {
    function add(uint a, uint b) public pure returns(uint) {
        return a + b;
    }
}

contract B {
    A a = new A();
    // contract 단에 있는 변수 네개 : contract, abstract, library, interface
    // 여기선 상태변수가 없기 때문에 library 방식으로 A가 쓰임. 
    function useAddOfA(uint x, uint y) public view returns (uint) {
       return a.add(x, y);
    }
}
/**
 * 9. 긴 숫자를 넣었을 때, 마지막 3개의 숫자만 반환하는 함수를 구현하세요.
    
    예) 459273 → 273 // 492871 → 871 // 92218 → 218
 * 
 */
contract TEST49 {
  function getLastThreeDigits(uint _number) public pure returns (uint) {
        return _number % 1000;
    }
}
/**
 * 10. 숫자 3개가 부여되면 그 3개의 숫자를 이어붙여서 반환하는 함수를 구현하세요. 
    
    예) 3,1,6 → 316 // 1,9,3 → 193 // 0,1,5 → 15 
    
    응용 문제 : 3개 아닌 n개의 숫자 이어붙이기
 */
contract TEST50 {
    function stringToUint(string memory s) public pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint i = 0; i < b.length; i++) {
            // Ensure each character is a valid digit (0-9)
            require(b[i] >= 0x30 && b[i] <= 0x39, "Invalid character: must be 0-9");
            // Calculate the numeric value of the character and update result
            result = result * 10 + (uint256(uint8(b[i])) - 48);
        }
        return result;
    }
    // function concatenateNums(uint[] memory nums) public pure returns(string memory) {
    //      string memory res;
    //     for (uint i = 0; i < nums.length; i++) {
    //         res = string.concat(res, uintString(nums[i]));
    //     }
    //     return _res;
    // }
    function concatenateNums(uint[] memory nums) public pure returns(string memory) {
         bytes memory res = new bytes(nums.length);
        for (uint i = 0; i < nums.length; i++) {
            res = abi.encodePacked(res, uintString(nums[i])); // string의 concat bytes 버전
        }     
        return string(res);
    }

    function getDigits(uint _n) public pure returns(uint) {
        uint idx = 1;
        while (_n > 10) {
            _n = _n / 10;
            idx++;
        }
        return idx;
    }

    function uintString(uint _num) public pure returns(string memory) {
        uint length = getDigits(_num);
        uint arrNum = length-1;
        bytes memory bString = new bytes(length); // 배열에 각각 숫자들을 저장할 것 

        while (_num > 0) {
            bString[arrNum] = bytes1(uint8(48 +_num % 10)); // 10진수 -> 16 진수 -> bytes
            _num /= 10;
            if (arrNum == 0) {
                break;
            }
            arrNum--;
        }

        return string(bString); // bytes => string
    }
}


contract TOSTRING {
    function A(uint _a) public pure returns(string memory) {
        return Strings.toString(_a);
    }

    // string.concat(a,b);
    function getNumbers(uint[] memory _numbers) public pure returns(string memory) {
        string memory _res;
        for(uint i=0; i<_numbers.length; i++) {
            _res = string.concat(_res, Strings.toString(_numbers[i]));
        }
        return _res;
    }

    function getDigits(uint _num) public pure returns(uint) {
        uint idx = 1;
        while(_num >= 10) {
            _num = _num/10;
            idx ++;
        }

        return idx;
    }

    function uintToBytes(uint8 _num) public pure returns(bytes1) {
        return bytes1(_num);
    }

    function uintToString(uint _num) public pure returns(bytes memory) {
        uint digits = getDigits(_num);
        bytes memory _b = new bytes(digits);
        if (_num == 0) {
            return "0";
        } else {
            while(_num != 0) {
                digits--;
                _b[digits] = bytes1(uint8(48+_num%10));
                _num /= 10;
            }
        
            return (_b);
        }
    }

    function FINAL(uint[] memory _num) public pure returns(string memory) {
        bytes memory _b = new bytes(_num.length);
        for(uint i=0; i<_num.length; i++) {
            _b = abi.encodePacked(_b, uintToString(_num[i]));
        }

        return string(_b);
    }
}

contract CONDITIONAL_OUTPUT {
    function get(uint _n) public pure returns(bytes memory) {
        if (_n > 5) {
            return abi.encodePacked("String");
        } else {
            return abi.encodePacked(_n);
        }
    }
}