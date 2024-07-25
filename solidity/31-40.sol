// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/*
string을 input으로 받는 함수를 구현하세요. "Alice"나 "Bob"일 때에만 true를 반환하세요
 */
contract TEST31 {
    function receiveStr(string memory str) public pure returns(bool){
      return (keccak256(abi.encodePacked(str)) == keccak256(abi.encodePacked('Alice')) || keccak256(abi.encodePacked(str)) == keccak256(abi.encodePacked('Bob') )) ? true : false;
    }
}

/**
 * 3의 배수만 들어갈 수 있는 array를 구현하되, 3의 배수이자 동시에 10의 배수이면 들어갈 수 없는 추가 조건도 구현하세요.
 * 3 → o , 9 → o , 15 → o , 30 → x
 */
contract TEST32 {
    uint[] nums;
    function onlyThree(uint num) public {
        require(num % 3 == 0 && num % 10 != 0, "nope");
        nums.push(num);
    }
}

/**
 * 이름, 번호, 지갑주소 그리고 생일을 담은 고객 구조체를 구현하세요. 
 * 고객의 정보를 넣는 함수와 고객의 이름으로 검색하면 해당 고객의 전체 정보를 반환하는 함수를 구현하세요.
 */
contract TEST33 {
    struct Customer {
        string name;
        uint number;
        address addr;
        uint birth;
    }
    mapping(string => Customer) customer;

    function pushCustomer(Customer memory _customer) public {
        customer[_customer.name] = _customer;

    }

    function getCustomer(string memory _name) public view returns(Customer memory) {
        return customer[_name];
    }
}

/**
 * 이름, 번호, 점수가 들어간 학생 구조체를 선언하세요.
 * 학생들을 관리하는 자료구조도 따로 선언하고 학생들의 전체 평균을 계산하는 함수도 구현하세요.
 */
contract TEST34 {
    struct Student {
        string name;
        uint number;
        uint score;
    }

    Student[] students;

    function pushStudent(Student memory student) public {
        students.push(student);
    }

    function getStudents() public view returns(Student[] memory) {
        return students;
    }

    function getAverage() public view returns(uint){
        uint sum;
        for (uint i = 0; i < students.length; i++) {
            sum += students[i].score;
        }
        return sum / students.length;
    }
}
/**
 * 5. 숫자만 들어갈 수 있는 array를 선언하고 해당 array의 짝수번째 요소만 모아서 반환하는 함수를 구현하세요.
    
    예) [1,2,3,4,5,6] -> [2,4,6] // [3,5,7,9,11,13,14] -> [5,9,13]
 */
contract TEST35 {
  uint[] array;
  function pushNum(uint num) public {
    array.push(num);
  }

  function onlyEvens() public view returns(uint[] memory) {
    uint[] memory evens = new uint[](array.length / 2);
    uint j;
    for (uint i = 1; i < array.length; i += 2) {
        evens[j] = array[i];
        j++;
    }
    return evens;
  }
}
/**
 * high, neutral, low 상태를 구현하세요. 
 * a라는 변수의 값이 7이상이면 high, 4이상이면 neutral 그 이후면 low로 상태를 변경시켜주는 함수를 구현하세요.
 */
contract TEST36 {
      enum Status { // 구조체랑 비슷
        high,
        neutral,
        low
    }

    
    function statusSetter(uint a) public pure returns(Status) {
        Status stat;
        if (a > 6) {
            stat = Status.high;
        } else if (a > 3) {
            stat = Status.neutral;
        } else {
            stat = Status.low;
        }
        return stat;
    }
}
/**
 * 7. 1 wei를 기부하는 기능, 1finney를 기부하는 기능 그리고 1 ether를 기부하는 기능을 구현하세요. 
 * 최초의 배포자만이 해당 smart contract에서 자금을 회수할 수 있고 다른 이들은 못하게 막는 함수도 구현하세요.
    
    (힌트 : 기부는 EOA가 해당 Smart Contract에게 돈을 보내는 행위, contract가 돈을 받는 상황)
 */
contract TEST37 {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    function donateWei() external payable {
        require(msg.value == 1 wei, "Must send 1 wei");
    }
    // Function to donate 1 ether
    function donateEther() external payable {
        require(msg.value == 1 ether, "Must send 1 ether");
    }

    // Function to withdraw funds, only callable by the owner
    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        payable(owner).transfer(address(this).balance);
        // contractA.call() // contractA한테 가는것
    }
    receive() external payable {}
    
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

/**
 * 8. 상태변수 a를 "A"로 설정하여 선언하세요. 
 * 이 함수를 "B" 그리고 "C"로 변경시킬 수 있는 함수를 각각 구현하세요. 단 해당 함수들은 오직 owner만이 실행할 수 있습니다. 
 * owner는 해당 컨트랙트의 최초 배포자입니다.
    
    (힌트 : 동일한 조건이 서로 다른 두 함수에 적용되니 더욱 효율성 있게 적용시킬 수 있는 방법을 생각해볼 수 있음)
 */
contract TEST38 {
    string a = "A";
    address owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can execute this function");
        _;
    }

    function changeToB() public onlyOwner {
        a = "B";
    }
    function changeToC() public onlyOwner {
        bytes memory stringBytes = new bytes(1);
        stringBytes[0] = 0x43;
        a = string(stringBytes);
    }
}

/**
 * 9. 특정 숫자의 자릿수까지의 2의 배수, 3의 배수, 5의 배수 7의 배수의 개수를 반환해주는 함수를 구현하세요.
    
    예) 15 : 7,5,3,2  (2의 배수 7개, 3의 배수 5개, 5의 배수 3개, 7의 배수 2개) 
    // 100 : 50,33,20,14  (2의 배수 50개, 3의 배수 33개, 5의 배수 20개, 7의 배수 14개)
 */
contract TEST39 {
    function getNums(uint num) public pure returns(uint, uint, uint, uint) {
        uint count2 = num / 2;
        uint count3 = num / 3;
        uint count5 = num / 5;
        uint count7 = num / 7;
        return (count2, count3, count5, count7);
    }
}

/**
 * 10. 숫자를 임의로 넣었을 때 내림차순으로 정렬하고 가장 가운데 있는 숫자를 반환하는 함수를 구현하세요. 
 * 가장 가운데가 없다면 가운데 2개 숫자를 반환하세요.
    
    예) [5,2,4,7,1] -> [1,2,4,5,7], 4 // [1,5,4,9,6,3,2,11] 
    -> [1,2,3,4,5,6,9,11], 4,5 // [6,3,1,4,9,7,8] -> [1,3,4,6,7,8,9], 6
 */contract TEST40 {
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
            
            uint[] memory median = new uint[](2 - arr.length % 2);
            if (median.length == 2) {
                median[0] = arr[arr.length / 2 - 1];
                median[1] = arr[arr.length / 2];
            } else {
                median[0] = arr[arr.length / 2];
            }
            return median;
        }
    }
}
