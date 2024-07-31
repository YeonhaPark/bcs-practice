// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/**
    Contract에 예치, 인출할 수 있는 기능을 구현하세요. 지갑 주소를 입력했을 때 현재 예치액을 반환받는 기능도 구현하세요.  
 */
contract TEST81 {
    mapping(address=>uint) balance;
    receive() external payable {}
    function withdraw(address addr) public {
        require(balance[addr] > 0);
        payable(addr).transfer(balance[addr]);
    }
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }
}
/**
특정 숫자를 입력했을 때 그 숫자까지의 3,5,8의 배수의 개수를 알려주는 함수를 구현하세요.
 */
contract TEST82 {
    function quotient(uint a) public pure returns (uint, uint, uint) {
        return(a / 3, a / 5, a / 8);
    }
}
/**
    이름, 번호, 지갑주소 그리고 숫자와 문자를 연결하는 mapping을 가진 구조체 사람을 구현하세요. 
    사람이 들어가는 array를 구현하고 array안에 push 하는 함수를 구현하세요.
 */

contract TEST83 {
    struct Person {
        string name;
        uint256 number;
        address walletAddress;
        mapping(uint256 => string) numberToString;
    }

    Person[] private people;
    uint256 private peopleCount;

    function addPerson(string memory _name, uint256 _number, address _walletAddress) public {
        Person storage newPerson = people.push();
        newPerson.name = _name;
        newPerson.number = _number;
        newPerson.walletAddress = _walletAddress;
        peopleCount++;
    }

    function addNumberStringMapping(uint256 _index, uint256 _key, string memory _value) public {
        require(_index < peopleCount, "Person does not exist");
        people[_index].numberToString[_key] = _value;
    }

    function getPerson(uint256 _index) public view returns (string memory, uint256, address) {
        require(_index < peopleCount, "Person does not exist");
        Person storage person = people[_index];
        return (person.name, person.number, person.walletAddress);
    }

    function getNumberToString(uint256 _index, uint256 _key) public view returns (string memory) {
        require(_index < peopleCount, "Person does not exist");
        return people[_index].numberToString[_key];
    }

    function getPeopleCount() public view returns (uint256) {
        return peopleCount;
    }
}
/**
2개의 숫자를 더하고, 빼고, 곱하는 함수들을 구현하세요. 단, 이 모든 함수들은 blacklist에 든 지갑은 실행할 수 없게 제한을 걸어주세요.
 */
contract TEST84 {
   mapping(address=>bool) blacklist;

    function addBlaclist(address addr) public {
        blacklist[addr] = true;
    }
    modifier blacklistCheck(address addr) {
        require(blacklist[addr] == false);
        _;
    }
    function add(uint a, uint b) public view blacklistCheck(msg.sender) returns(uint) {
        return a + b;
    }
    function sub(uint a, uint b) public view blacklistCheck(msg.sender) returns(uint) {
        return a - b;
    }
    function mul(uint a, uint b) public view blacklistCheck(msg.sender) returns(uint) {
        return a * b;
    }

}

/**
숫자 변수 2개를 구현하세요. 한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다. 
찬성, 반대 투표는 배포된 후 20개 블록동안만 진행할 수 있게 해주세요.
 */
contract TEST85 {
    uint yes;
    uint no;
    uint blocks;
    constructor() {
        blocks = block.number;
    }
    function vote(bool v) public {
        require(blocks + 20 >= block.number);
        if (v) {
            yes++;
        } else {
            no++;
        }
    }
}
/**
 * 숫자 변수 2개를 구현하세요. 한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다. 
 * 찬성, 반대 투표는 1이더 이상 deposit한 사람만 할 수 있게 제한을 걸어주세요.
 */
contract TEST86 {
    uint yes;
    uint no;
    mapping(address=>uint) balance;
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }
    function vote(bool v) public {
        require(balance[msg.sender] >= 1 ether);
        if (v) {
            yes++;
        } else {
            no++;
        }
    }
}
/**
    visibility에 신경써서 구현하세요. 
    
    숫자 변수 a를 선언하세요. 
    해당 변수는 컨트랙트 외부에서는 볼 수 없게 구현하세요. 변화시키는 것도 오직 내부에서만 할 수 있게 해주세요.
 */
contract TEST87 {
    uint private a;
    function change(uint _a) private {
        a = _a;
    }
}
/**
 아래의 코드를 보고 owner를 변경시키는 방법을 생각하여 구현하세요.
 */
contract OWNER {
	address private owner;

	constructor() {
		owner = msg.sender;
	}

    function setInternal(address _a) internal virtual {
        owner = _a;
    }

    function getOwner() public view returns(address) {
        return owner;
    }
}

contract Successor is OWNER {

    function setInternal(address _a) internal override {
        OWNER.setInternal(_a);
    }
        function setOwner(address _a) public {
        setInternal(_a);
    }
}

/**
이름과 자기 소개를 담은 고객이라는 구조체를 만드세요. 
이름은 5자에서 10자이내 자기 소개는 20자에서 50자 이내로 설정하세요. 
(띄어쓰기 포함 여부는 신경쓰지 않아도 됩니다. 더 쉬운 쪽으로 구현하세요.)
 */

contract TEST89 {
    struct Customer {
        string name;
        string myself;
    }

    Customer[] public customers;

    function addCustomer(string memory _name, string memory _myself) public {
        require(isValidName(_name), "Name must be between 5 and 10 characters");
        require(isValidIntroduction(_myself), "Introduction must be between 20 and 50 characters");

        Customer memory newCustomer = Customer(_name, _myself);
        customers.push(newCustomer);
    }

    function isValidName(string memory _name) private pure returns (bool) {
        bytes memory nameBytes = bytes(_name);
        return nameBytes.length >= 5 && nameBytes.length <= 10;
    }

    function isValidIntroduction(string memory _myself) private pure returns (bool) {
        bytes memory myselfBytes = bytes(_myself);
        return myselfBytes.length >= 20 && myselfBytes.length <= 50;
    }

    function getCustomer(uint256 index) public view returns (string memory, string memory) {
        require(index < customers.length, "Customer does not exist");
        Customer memory customer = customers[index];
        return (customer.name, customer.myself);
    }

    function getCustomerCount() public view returns (uint256) {
        return customers.length;
    }
}
/**
 * 당신 지갑의 이름을 알려주세요. 아스키 코드를 이용하여 byte를 string으로 바꿔주세요.
 */

contract TEST90 {
    bytes private walletNameBytes;

    constructor(bytes memory _nameBytes) {
        walletNameBytes = _nameBytes;
    }

    function setWalletName(bytes memory _nameBytes) public {
        walletNameBytes = _nameBytes;
    }

    function getWalletNameAsBytes() public view returns (bytes memory) {
        return walletNameBytes;
    }

    function getWalletNameAsString() public view returns (string memory) {
        return bytesToString(walletNameBytes);
    }

    function bytesToString(bytes memory _bytes) private pure returns (string memory) {
        uint8[] memory asciiArray = new uint8[](_bytes.length);
        for (uint i = 0; i < _bytes.length; i++) {
            asciiArray[i] = uint8(_bytes[i]);
        }
        
        bytes memory stringBytes = new bytes(asciiArray.length);
        for (uint i = 0; i < asciiArray.length; i++) {
            stringBytes[i] = bytes1(asciiArray[i]);
        }
        
        return string(stringBytes);
    }
}