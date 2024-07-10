// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
    더하기, 빼기, 곱하기, 나누기 그리고 제곱을 반환받는 계산기를 만드세요.
*/

contract TEST1 {
    function add(uint _a, uint num) public pure returns(uint) {
        return _a + num;
    }
    function mul(uint _a, uint num) public pure returns(uint) {
        return _a * num;
    }
    function div(uint _a, uint num) public pure returns(uint) {
        return _a / num;
    }
    function pow(uint _a, uint num) public pure returns(uint) {
        return _a ** num;
    }
}

/*
    2개의 Input값을 가지고 1개의 output값을 가지는 4개의 함수를 만드시오. 
    각각의 함수는 더하기, 빼기, 곱하기, 나누기(몫)를 실행합니다.
*/

contract TEST2 {
    function add(uint _a, uint _b) public pure returns(uint) {
        return _a + _b;
    }
    function sub(uint _a, uint _b) public pure returns(uint) {
        return _a - _b;
    }
    function mul(uint _a, uint _b) public pure returns(uint) {
        return _a * _b;
    }
    function div(uint _a, uint _b) public pure returns(uint) {
        return _a / _b;
    }
}

/*
    1개의 Input값을 가지고 1개의 output값을 가지는 2개의 함수를 만드시오. 
    각각의 함수는 제곱, 세제곱을 반환합니다.
*/

contract TEST3 {
    function square(uint num) public pure returns(uint) {
        return num ** 2;
    }
    function cube(uint num) public pure returns(uint) {
        return num ** 3;
    }
}
/*
    이름(string), 번호(uint), 듣는 수업 목록(string[])을 담은 student라는 구조체를 만들고 
    그 구조체들을 관리할 수 있는 array, students를 선언하세요.
*/

contract TEST4 {
    struct Student {
        string name;
        uint number;
        string[] classes;
    }

    Student[] students;
}

/*
    아래의 함수를 만드세요
    1~3을 입력하면 입력한 수의 제곱을 반환받습니다.
    4~6을 입력하면 입력한 수의 2배를 반환받습니다.
    7~9를 입력하면 입력한 수를 3으로 나눈 나머지를 반환받습니다.
*/

contract TEST5 {
    function oneToThree(uint n) public pure returns(uint){
        if (n >= 1 && n <= 3) {
            return n ** 2;
        } else if (n >= 4 && n <= 6) {
            return n * 2;
        } else if (n >= 7 && n <= 9) {
            return n % 3;
        } else {
            revert("The number is out of range");
        }
    }
}

/*
    숫자만 들어갈 수 있는 array numbers를 만들고 
    그 array안에 0부터 9까지 자동으로 채우는 함수를 구현하세요.(for 문)
*/

contract TEST6 {
    uint[10] numbers;
    function fillToNine() public {
        for (uint i = 0; i < 10; i++) {
            numbers[i] = i;
        }
    }

    function getNumbers() public view returns(uint[10] memory) {
        return numbers;
    }
}

/*
    숫자만 들어갈 수 있는 array numbers를 만들고 
    그 array안에 0부터 5까지 자동으로 채우는 함수와 
    array안의 모든 숫자를 더한 값을 반환하는 함수를 각각 구현하세요.(for 문)
*/

contract TEST7 {
    uint[] numbers;

    function fill() public {
        for (uint i = 0; i < 6; i++) {
            numbers.push(i);
        }
    }

    function sum() public view returns(uint) {
        uint i = 0;
        uint s = 0;
        while (i < numbers.length) {
            s += numbers[i];
            i++;
        }
        return s;
    }
}

/*
    아래의 함수를 만드세요
    1~10을 입력하면 “A” 반환받습니다.
    11~20을 입력하면 “B” 반환받습니다.
    21~30을 입력하면 “C” 반환받습니다.
*/

contract TEST8 {
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


/*
   문자형을 입력하면 bytes 형으로 변환하여 반환하는 함수를 구현하세요.
*/

contract TEST9 {
    function convert(string memory str) public pure returns(bytes memory) {
        return bytes(str);
    }

    function bytesToString(bytes memory _b) public pure returns(string memory) {
        return string(_b);
    }
}

/*
   숫자만 들어가는 array numbers를 선언하고 숫자를 넣고(push), 빼고(pop), 
   특정 n번째 요소의 값을 볼 수 있는(get)함수를 구현하세요.
*/

contract TEST10 {
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

contract Convert {
    function unitToBytes(uint _n) public pure returns(bytes memory) {
        return abi.encodePacked(_n);
    }

    function unit8ToBytes1(uint8 _n) public pure returns(bytes1) {
        return bytes1(_n);
    }
    function bytes1ToUint8(bytes1 _b) public pure returns(uint8) {
        return uint8(_b);
    }
    function bytesToUint(bytes2 _b) public pure returns(uint) {
        return uint16(_b);
    }
    function splitBytes(bytes memory _b) public pure returns(bytes1) {
        return _b[0];
    }
}

contract ABI {
    function getBytes(string memory _s) public pure returns(bytes memory) {
        return bytes(_s);
    }

    // 밸류만 나옴. 
    function getabiEncodePacked(string memory _s) public pure returns(bytes memory) {
        return abi.encodePacked(_s);
    }
    // 0000000000000000000000000000000000000000000000000000000000000020 1번 의자. 32번째 자리가 끝자리. 여기서 20은 오프셋, 즉 자리. 
    // 0000000000000000000000000000000000000000000000000000000000000002
    // 6162000000000000000000000000000000000000000000000000000000000000
    // 전체의 결과물
    function getabiEncode(string memory _s) public pure returns(bytes memory) {
        return abi.encode(_s);
    }
    // 0000000000000000000000000000000000000000000000000000000000000040 1) 64byte,, 128 번째 자리 가니깐 길이 2짜리가 온다.
    // 0000000000000000000000000000000000000000000000000000000000000080 2) This indicates that the dynamic data for _s2 starts at the 128th byte
    // 0000000000000000000000000000000000000000000000000000000000000002 02: 두 개다. actual data가 시작되는 지점
    // 6162000000000000000000000000000000000000000000000000000000000000 1)이 시작되는 지점
    // 0000000000000000000000000000000000000000000000000000000000000002 02: 두 개다.
    // 6364000000000000000000000000000000000000000000000000000000000000 2)가 시작되는 지점
    function getabiEncode2(string memory _s1, string memory _s2) public pure returns(bytes memory) {
        return abi.encode(_s1, _s2);
    }
    function getabiEncode3(string memory _s1, string memory _s2) public pure returns(bytes memory) {
        return abi.encode(_s1, _s2);
    }
    // 0000000000000000000000000000000000000000000000000000000000000040 string의 offset
    // 0000000000000000000000000000000000000000000000000000000000000020
    // 0000000000000000000000000000000000000000000000000000000000000003
    // 6162630000000000000000000000000000000000000000000000000000000000
    function getabiEncode4(string memory _s, uint _n) public pure returns(bytes memory) {
        return abi.encode(_s, _n);
    }

    // 0000000000000000000000000000000000000000000000000000000000000020
    // 0000000000000000000000000000000000000000000000000000000000000040
    // 0000000000000000000000000000000000000000000000000000000000000003
    // 6162630000000000000000000000000000000000000000000000000000000000
    function getabiEncode5( uint _n, string memory _s) public pure returns(bytes memory) {
        return abi.encode(_n, _s);
    }
    // 0000000000000000000000000000000000000000000000000000000000000020 offset
    // 0000000000000000000000000000000000000000000000000000000000000004 자릿수
    // 0000000000000000000000000000000000000000000000000000000000000010 16
    // 0000000000000000000000000000000000000000000000000000000000000020 20 
    // 0000000000000000000000000000000000000000000000000000000000000040
    // 0000000000000000000000000000000000000000000000000000000000000080
    function getabiEncode6(uint[] memory _n) public pure returns(bytes memory) {
        return abi.encode(_n);
    }
}