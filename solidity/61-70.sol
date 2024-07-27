// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
 * a의 b승을 반환하는 함수를 구현하세요.
 */
contract TEST61 {
    function exponentiation(uint a,uint b) public pure returns(uint) {
        return a ** b;
    }
}


/**
 * 2개의 숫자를 더하는 함수, 
 * 곱하는 함수 a의 b승을 반환하는 함수를 구현하는데 
 * 3개의 함수 모두 2개의 input값이 10을 넘지 않아야 하는 조건을 최대한 효율적으로 구현하세요
 */
contract TEST62 {
   modifier inputChecker(uint a, uint b) {
      require(a <= 10 && b <= 10, "Both numbers cannot exceed 10");
      _;
   }
   function add(uint a, uint b) public pure inputChecker(a, b) returns(uint) {
      return a + b;
   }
   function multiply(uint a, uint b) public pure inputChecker(a, b) returns(uint) {
      return a * b;
   }
   function exponentiate(uint a, uint b) public pure inputChecker(a, b) returns(uint) {
      return a ** b;
   }
}
/**
 * 2개 숫자의 차를 나타내는 함수를 구현하세요.
 */
 contract TEST63 {
   function sub(uint a, uint b) public pure returns(uint) {
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
 * 지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.
 */
contract TEST64 {
   function convertTo4Bytse(address addr) public pure returns(bytes[5] memory) {
      bytes20 addressBytes = bytes20(addr);
      bytes[5] memory segments;
      for (uint i = 0; i < 5; i++) {
         bytes memory segment = new bytes(4); // 0x12345678
           for (uint j = 0; j < 4; j++) {
                segment[j] = addressBytes[i * 4 + j]; // 0, 1, 2, 3, 
            }
            segments[i] = segment;
      }
      return segments;
   }
}
/**
 * 1. 숫자 3개를 입력하면 그 제곱을 반환하는 함수를 구현하세요. 그 3개 중에서 가운데 출력값만 반환하는 함수를 구현하세요.
    
    예) func A : input → 1,2,3 // output → 1,4,9 | func B : output 4 (1,4,9중 가운데 숫자)
 */
contract TEST65 {
   function returnSquare(uint a, uint b, uint c) public pure returns(uint, uint, uint) {
      return (a ** 2, b ** 2, c ** 2);
   }

   function getMiddle(uint a, uint b, uint c) public pure returns(uint) {
      (, uint middle, ) = returnSquare(a, b, c);
      return middle;
   }
}
/**
 * 특정 숫자를 입력했을 때 자릿수를 알려주는 함수를 구현하세요. 
 * 추가로 그 숫자를 5진수로 표현했을 때는 몇자리 숫자가 될 지 알려주는 함수도 구현하세요.
 */
 contract TESET66 {
   function getDigits(uint a) public pure returns(uint) {
      uint digit = 1;
      while (a > 0) { // 11 ?
         a /= 10; // 1
         if (a == 0) break;
         digit++; // 2
      }
      return digit;
   }

   function getQuinaryDigits(uint a) public pure returns(uint) { // quinary(25)) => 100 
      uint digit = 1; // 11
      while (a > 0) {
         a /= 5; // 2
         if (a == 0) break;
         digit++; // 2
      }
      return digit;
   }
 }
/**
 * 1. 자신의 현재 잔고를 반환하는 함수를 보유한 Contract A와 다른 주소로 돈을 보낼 수 있는 Contract B를 구현하세요.
    
    B의 함수를 이용하여 A에게 전송하고 A의 잔고 변화를 확인하세요.
 */
 contract A {
   receive() external payable {}
   function myBalance() public view returns(uint) {
      return address(this).balance;
   }
 }

 contract B {
    receive() external payable {}
    // 이것도 되고 아래 send도 됨
   //  function transferTo(address to, uint amount) public {
   //      require(address(this).balance >= amount, "Insufficient balance in contract B");
   //      payable(address(to)).transfer(amount);
   //  }
    function send(address payable _sendTo) public payable {
        (bool success, ) = _sendTo.call{value : msg.value}("");
        require(success, "Transfer Failed");

    }
   function deposit() public payable {}
    // Function to check the balance of contract A
    function checkBalance(address from) public view returns(uint) {
        return address(from).balance;
    }

 }
 contract B2 {
    receive() external payable {}
    // 이것도 되고 아래 send도 됨
   //  function transferTo(address to, uint amount) public {
   //      require(address(this).balance >= amount, "Insufficient balance in contract B");
   //      payable(address(to)).transfer(amount);
   //  }
    constructor() payable {}
    function send(address payable _sendTo) public payable {
        (bool success, ) = _sendTo.call{value : msg.value}("");
        require(success, "Transfer Failed");

    }
   function deposit() public payable {}
    // Function to check the balance of contract A
    function checkBalance(address from) public view returns(uint) {
        return address(from).balance;
    }

 }
/**
 * 1. 계승(팩토리얼)을 구하는 함수를 구현하세요. 계승은 그 숫자와 같거나 작은 모든 수들을 곱한 값이다. 
    
    예) 5 → 1*2*3*4*5 = 60, 11 → 1*2*3*4*5*6*7*8*9*10*11 = 39916800
    
    while을 사용해보세요
 */
contract TEST68 {
    function factorial(uint number) public pure returns(uint) {
        uint res = number;
        while (res > 0) {
            res *= number;
            number--;
        }
    return res;
    }
}
/**
 * 1. 숫자 1,2,3을 넣으면 1 and 2 or 3 라고 반환해주는 함수를 구현하세요.
    
    힌트 : 7번 문제(시,분,초로 변환하기)
 */
contract TEST69 {
   function uintToBytes(uint a) public pure returns(bytes memory) {
      bytes memory bytr = new bytes(1);
      bytr[0] = bytes1(uint8(48 + a));
      return bytr;
     
   }
    function uint2str(uint _i) public pure returns (bytes memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i; // 1
        uint len;
        while (j != 0) {
            len++; // 1
            j /= 10;
        }
        bytes memory bstr = new bytes(len); // 1 set
        uint k = len; // 1
        while (_i != 0) {
            k = k-1; // 0
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));// temp = 0
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return bstr;
    }
    function convertNum(uint a, uint b, uint c) public pure returns(string memory) {
      return string(abi.encodePacked(uintToBytes(a), " and ", uintToBytes(b), " or ", uintToBytes(c))); 
    }
}
/**
 * 번호와 이름 그리고 bytes로 구성된 고객이라는 구조체를 만드세요. 
 * bytes는 번호와 이름을 keccak 함수의 input 값으로 넣어 나온 output값입니다. 
 * 고객의 정보를 넣고 변화시키는 함수를 구현하세요. 
 */
 contract TEST70 {
   struct Customer {
      uint number;
      string name;
      bytes32 data;
   }
   function setBytes(uint number, string memory name) public pure returns(Customer memory) {
      bytes32 hashedData = keccak256(abi.encodePacked(number, name)); // 64자리. 
      Customer memory customer = Customer(
         {
            number: number, 
            name: name, 
            data: hashedData
         });
      return customer;
   }
 }