
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/**
은행에 관련된 어플리케이션을 만드세요.
은행은 여러가지가 있고, 유저는 원하는 은행에 넣을 수 있다. 
국세청은 은행들을 관리하고 있고, 세금을 징수할 수 있다. 
세금은 간단하게 전체 보유자산의 1%를 징수한다. 세금을 자발적으로 납부하지 않으면 강제징수한다. 

* 회원 가입 기능 - 사용자가 은행에서 회원가입하는 기능
* 입금 기능 - 사용자가 자신이 원하는 은행에 가서 입금하는 기능
* 출금 기능 - 사용자가 자신이 원하는 은행에 가서 출금하는 기능
* 은행간 송금 기능 1 - 사용자의 A 은행에서 B 은행으로 자금 이동 (자금의 주인만 가능하게)
* 은행간 송금 기능 2 - 사용자 1의 A 은행에서 사용자 2의 B 은행으로 자금 이동
* 세금 징수 - 국세청은 주기적으로 사용자들의 자금을 파악하고 전체 보유량의 1%를 징수함. 세금 납부는 유저가 자율적으로 실행. (납부 후에는 납부 해야할 잔여 금액 0으로)
-------------------------------------------------------------------------------------------------
* 은행간 송금 기능 수수료 - 사용자 1의 A 은행에서 사용자 2의 B 은행으로 자금 이동할 때 A 은행은 그 대가로 사용자 1로부터 1 finney 만큼 수수료 징수.
* 세금 강제 징수 - 국세청에게 사용자가 자발적으로 세금을 납부하지 않으면 강제 징수. 은행에 있는 사용자의 자금이 국세청으로 강제 이동
*/ 
contract Bank {
    string name;
    mapping(address=>string) userId;
    mapping(string => string) userPw;
    mapping(address => uint) balance;
    constructor(string memory _name) {
        name = _name;
    }

    function join(string memory id, string memory pw) public {
        if (keccak256(abi.encodePacked(userId[msg.sender])) == keccak256(abi.encodePacked((id)))) {
            revert("Account already exists");
        } else {
            userId[msg.sender] = id;
            userPw[id] = pw;
        }
    }

    function deposit(uint amount) public {
        balance[tx.origin] += amount;
    }

    function withdraw(uint amount) public {
        balance[tx.origin] -= amount;
        payable(tx.origin).transfer(amount);
    }

    function transferTo(address to, uint amount) public {
        payable(to).transfer(amount);
    }
}
contract NTS {
    mapping(address=>uint) tax;

    function askTax(uint totalBalance) public { // tx. origin 이 사용하는 은행을 검색 , 은행의 blaance를 for loop
        (tx.origin).balance;
        Application application = Application();
    }
}
contract Application {
    
    Bank[] banks;

    Bank A = new Bank("A");
    Bank B = new Bank("B");
    Bank C = new Bank("C");
    mapping(address => Bank[]) userBanks;
  
    function join(string memory bankName, string memory id, string memory pw) public {
        Bank bankToJoin = new Bank(bankName);
        banks.push(bankToJoin);
        bankToJoin.join(id, pw);
    }

    function compareStrings(string memory a, string memory b) public pure returns(bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    function findBank(string memory bankName) public view returns(Bank) {
        Bank targetBank;
        if (compareStrings(bankName,"A")) {
            targetBank = A;
        } else if (compareStrings(bankName,"B")) {
            targetBank = B;
        } else if (compareStrings(bankName,"C")) {
            targetBank = C;
        } else {
            revert("bank doesn't exist");
        }
        return targetBank;

    }
    function deposit(string memory bankName, uint amount) public {
        Bank bankTo = findBank(bankName);
        bankTo.deposit(amount);
    }

    function withdraw(string memory bankName, uint amount) public {
        Bank bankFrom = findBank(bankName);
        bankFrom.withdraw(amount);
    }

    function transferBetweenBanks(string memory bankName1, string memory bankName2, uint amount) public {
        withdraw(bankName1, amount);
        deposit(bankName2, amount);
    }
    function transferToAnother(string memory bankName1, string memory bankName2, address to, uint amount) public {
        withdraw(bankName1, amount);
        Bank bankTo = findBank(bankName2);
        bankTo.transferTo(to, amount);
    }

    function payTax() public {
        NTS nts = new NTS();
        uint total;
        for (uint i = 0; i < userBanks[msg.sender].length; i++) {
            total += address(userBanks[msg.sender][i]).balance;
        }
        nts.askTax(total);
    }
 }