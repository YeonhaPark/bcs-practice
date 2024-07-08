// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
 * uint 형이 들어가는 array를 선언하고, 짝수만 들어갈 수 있게 걸러주는 함수를 구현하세요.
 */
contract TEST11 {
    uint[] array;
    function onlyEven(uint num) public {
        if (num % 2 == 0) {
            array.push(num);
        }
    }
}

/**
 * 숫자 3개를 더해주는 함수, 곱해주는 함수 그리고 순서에 따라서 a*b+c를 반환해주는 함수 3개를 각각 구현하세요.
 */

contract TEST12 {
    uint[3] numbers;
    function setNumbers(uint[3] memory _numbers) public {
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = _numbers[i];
        }
    }
    function add() public view returns(uint) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    function multiply() public view returns(uint) {
        uint mul = 1;
        for (uint i = 0; i < numbers.length; i++) {
            mul *= numbers[i];
        }
        return mul;
    }

    function math() public view returns(uint) {
        return numbers[0] * numbers[1] + numbers[2];
    }
}
/**
 * 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
 */
contract TEST13 {
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
 * 학번, 이름, 듣는 수험 목록을 포함한 학생 구조체를 선언하고 학생들을 관리할 수 있는 array를 구현하세요. 
 * array에 학생을 넣는 함수도 구현하는데 학생들의 학번은 1번부터 순서대로 2,3,4,5 자동 순차적으로 증가하는 기능도 같이 구현하세요.
 */
contract TEST14 {
    struct Student {
        uint number;
        string name;
        string[] classes;
    }

    Student[] students;

    function addStudent(string memory _name, string[] memory _classes) public {
        uint _number = students.length + 1;
        students.push(Student(_number, _name, _classes));
    }

    function getStudents() public view returns(Student[] memory) {
        return students;
    }
}
/**
 * 배열 A를 선언하고 해당 배열에 0부터 n까지 자동으로 넣는 함수를 구현하세요. 
 */
contract TEST15 {
    uint[] A;
    function fill(uint n) public {
        uint num = 0;
        while (num <= n) {
            A.push(num);
            num++;
        }
    }

    function getA() public view returns(uint[] memory) {
        return A;
    }
}
/**
 * 숫자들만 들어갈 수 있는 array를 선언하고 해당 array에 숫자를 넣는 함수도 구현하세요. 
 * 또 array안의 모든 숫자의 합을 더하는 함수를 구현하세요.
 */
contract TEST16 {
    uint[] array;

    function pushNum(uint num) public {
       array.push(num);
    }
    function sumNum() public view returns(uint) {
        uint sum = 0;
        for (uint i = 0; i < array.length; i++) {
            sum += array[i];
        }
        return sum;
    }
}
/**
 * string을 input으로 받는 함수를 구현하세요. 
 * 이 함수는 true 혹은 false를 반환하는데 Bob이라는 이름이 들어왔을 때에만 true를 반환합니다. 
 */
contract TEST17 {
    function isBob(string memory name) public pure returns(bool) {
       return keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Bob"));
    }
}
/**
 * 이름을 검색하면 생일이 나올 수 있는 자료구조를 구현하세요. (매핑) 
 * 해당 자료구조에 정보를 넣는 함수, 정보를 볼 수 있는 함수도 구현하세요.
 */
contract TEST18 {
    mapping(string => uint) birthDay;

    function setBirthday(string memory name, uint birthday) public {
        birthDay[name] = birthday;
    }

    function getBirthday(string memory name) public view returns (uint) {
        return birthDay[name];
    }
}
/**
 * 숫자를 넣으면 2배를 반환해주는 함수를 구현하세요. 단 숫자는 1000이상 넘으면 함수를 실행시키지 못하게 합니다.
 */
contract TEST19 {
    function double(uint num) public pure returns(uint) {
        require(num < 1000, "Required number is less than 1000");
        return num * 2;
    }
}

/**
 * 숫자만 들어가는 배열을 선언하고 숫자를 넣는 함수를 구현하세요.
 * 15개의 숫자가 들어가면 3의 배수 위치에 있는 숫자들을 초기화 시키는(3번째, 6번째, 9번째 등등) 함수를 구현하세요. 
 * (for 문 응용 → 약간 까다로움)
 */
contract TEST20 {
    uint[] numbers;
    function init() public {
        for (uint i = 2; i < numbers.length; i += 3) {
            numbers[i] = 0;
        }
    }

    function getNumbers() public view returns(uint[] memory) {
        return numbers;
    }
    function addNum(uint num) public {
        numbers.push(num);
        if (numbers.length == 15) {
            init();
        }
    }
}