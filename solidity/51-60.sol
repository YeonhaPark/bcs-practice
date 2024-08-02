// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/**
 * 숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.
 */

contract TEST51 {
    uint[] nums;

    function setNumbers(uint[] memory _nums) public {
        nums = _nums;
    }

    function getNumbers() public view returns(uint[] memory) {
        return nums;

    }
    function getThirdBiggest() public returns(uint){
        for (uint i = 0; i < nums.length; i++) {
            for (uint j = i + 1; j < nums.length; j++) {// 11, 3, 53, 81, 2, 6
                if (nums[j] > nums[i]) {
                    (nums[j], nums[i]) = (nums[i], nums[j]);
                }
            }
        }
        return nums[2];
    }

}

/**
 * 자동으로 아이디를 만들어주는 함수를 구현하세요. 
 * 이름, 생일, 지갑주소를 기반으로 만든 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.
 */
contract TEST52 {
        function createId(string memory _name, uint _birthday, address _addr) public pure returns (bytes10) {
        return bytes10(keccak256(abi.encodePacked(_name,_birthday,_addr))); // keccak256의 결과는 bytes32
    }
}

/**
 * 시중에는 A,B,C,D,E 5개의 은행이 있습니다. 각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다. 
 * 각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요.
 * 힌트 : 이중 mapping을 꼭 이용하세요.
 */

contract TEST53 { // Bank contract 만들어서도 해보기!
    address payable A;
    address payable B;
    address payable C;
    address payable D;
    address payable E;
    mapping(address => mapping(address => uint)) balance;
    constructor(address payable _A, address payable _B, address payable _C, address payable _D, address payable _E) {
        A = _A;
        B = _B;
        C = _C;
        D = _D;
        E = _E;
    }
    function deposit(address bank, uint amount) public payable {
        require(bank == A || bank == B || bank == C || bank == D || bank == E, "No bank matched");
        balance[bank][msg.sender];
        payable(bank).transfer(amount);
    }
    function withdraw(address bank, uint amount) public payable {
        require(bank == A || bank == B || bank == C || bank == D || bank == E, "No bank matched");
        require(amount <= balance[bank][msg.sender]);
        payable(msg.sender).transfer(amount);
    }
}
/**
 * 기부받는 플랫폼을 만드세요. 가장 많이 기부하는 사람을 나타내는 변수와 그 변수를 지속적으로 바꿔주는 함수를 만드세요.
 * 힌트 : 굳이 mapping을 만들 필요는 없습니다.
 */
contract TEST54 {
    address public honor;
    uint public max;
    function donation() public payable {
        if (msg.value > max) {
            max = msg.value;
            honor = msg.sender;
        }
    }
}
/**
 * 배포와 함께 owner를 설정하고 owner를 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.
 */
contract TEST55 {
    address owner;
    constructor(address _owner) {
        owner = _owner;
    }

    function changeOwner(address _newOwner) public {
        require(msg.sender == owner, "nope");
        owner = _newOwner;
    }
}
/**
 * 위 문제의 확장버전입니다. owner와 sub_owner를 설정하고 owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.
 */
contract TEST56 {
    address owner;
    address subowner;

    mapping(address =>bool) ownerPermit;
    mapping(address =>bool) subownerPermit;
    constructor(address _addr) {
        owner = msg.sender;
        subowner = _addr;
    }

    function receivePermit(bool) public  {
        if (msg.sender == owner) {
            ownerPermit[msg.sender] = true;
        }
        if (msg.sender == subowner) {
            subownerPermit[msg.sender] = true;
        }
    }

    function changeOwner(address newOwner) public {
         require(ownerPermit[owner] && subownerPermit[subowner], "require permits");
         owner = newOwner;
    }

    function setSubOwner(address _subowner) public {
        require(msg.sender == owner, "nope");
        subowner = _subowner;
    }       
}
/**
 * 위 문제의 또다른 버전입니다. 
 * owner가 변경할 때는 바로 변경가능하게 sub-owner가 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.
 */
contract TEST57 {
    address owner;
    address subowner;
    mapping(address =>bool) ownerPermit;
    constructor(address _owner) {
        owner = _owner;
    }

    function givePermit(bool) public {
        require(msg.sender == owner, "must be owner");
        ownerPermit[msg.sender] = true;
    }

    function changeOwner(address newOwner) public {
        if (msg.sender == owner) {
            owner = newOwner;
        } else if (msg.sender == subowner) {
             require(ownerPermit[owner], "require permits");
             owner = newOwner;

        }
    }

    function setSubOwner(address _subowner) public {
        require(msg.sender == owner, "nope");
        subowner = _subowner;
    }       
}
/**
 * A contract에 a,b,c라는 상태변수가 있습니다. 
 * a는 A 외부에서는 변화할 수 없게 하고 싶습니다. 
 * b는 상속받은 contract들만 변경시킬 수 있습니다. 
 * c는 제한이 없습니다. 각 변수들의 visibility를 설정하세요.
 */
contract TEST58 {
    uint private a;
    uint internal b;
    uint public c;
}
/**
 * 현재시간을 받고 2일 후의 시간을 설정하는 함수를 같이 구현하세요.
 */

contract TEST59 {
    uint public twoDaysAfter;
    function setTwoDaysAfter() public {
        twoDaysAfter = block.timestamp + 60 * 60 * 24 * 2;
    }
}
/**
 * 방이 2개 밖에 없는 펜션을 여러분이 운영합니다. 
 * 각 방마다 한번에 3명 이상 투숙객이 있을 수는 없습니다. 
 * 특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와 그 자료구조로부터 값을 얻어오는 함수를 구현하세요.
    
    예약시스템은 운영하지 않아도 됩니다. 과거의 일만 기록한다고 생각하세요.
    
    힌트 : 날짜는 그냥 숫자로 기입하세요. 예) 2023년 5월 27일 → 230527
 */
contract TEST60 {
    mapping(uint => mapping(uint => string[])) guests;

    function getGuestsHistory(uint date, uint index) public view returns(string[] memory) {
        return guests[date][index];
    }

    function setGuestsHistory(uint date, uint index, string[] memory _guests) public {
        require(index < 2 && _guests.length < 3);
        guests[date][index] = _guests;
    }
}