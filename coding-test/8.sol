// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/**
 *
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. 
안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요. 

사용자는 자신의 이름과 주소, 
자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)

* 사용자 등록 기능 - 사용자를 등록하는 기능
* 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
* 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
* 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 
- (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
* 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
-------------------------------------------------------------------------------------------------
* 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 
전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각 => 70 % * 66 % = 47 명
 */


// 토큰이 staking의 부분은 여기서 쳐내짐. 
contract Reunion {
    struct Agenda {
        uint number;
        string title;
        string content;
        address raisedBy;
        uint supporterVotes;
        uint opponentVotes;
        status result;
        uint blockNumber;
    }

    struct Voter {
        string name;
        address addr;
        string[] agendas;
        mapping(string => bool) voteResult;
        mapping(string => bool) voted;
    }
    mapping(string => Agenda) public agendaByTitle;
    mapping(address => Agenda) agendaByAddr;
    mapping(address => Agenda[]) agendasByAddr;
    mapping(address => Voter) voters;
    uint voterCount;
    uint agendaCount = 1;
    enum status {
        ongoing,
        passed,
        failed
    }

    // 사용자 등록 기능 - 사용자를 등록하는 기능
    function registerVoter(string calldata name) public {
        require(voters[msg.sender].addr == address(0));
        voters[msg.sender].name = name;
        voters[msg.sender].addr = msg.sender;
        voterCount++;
    }


    // 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function getAgenda(string calldata _title) public view returns(Agenda memory) {
        return agendaByTitle[_title];
    }
    // 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function voteFor(string calldata _title, bool vote) public {
        require(voters[msg.sender].addr != address(0));
        require(voters[msg.sender].voteResult[_title] == false && agendaByTitle[_title].result == status.ongoing);
        require(block.number <= agendaByTitle[_title].blockNumber + 15);
        vote ? agendaByTitle[_title].supporterVotes++ : agendaByTitle[_title].opponentVotes++;
        voters[msg.sender].voted[_title] = true;
        voters[msg.sender].voteResult[_title] = vote;
    }
    // 전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
    function setResult(string calldata _title) public returns(status) {
        require(agendaByTitle[_title].blockNumber + 15 <= block.number); // 실습 4번 web3.js
        uint total = agendaByTitle[_title].supporterVotes + agendaByTitle[_title].opponentVotes;
        uint pro =  agendaByTitle[_title].supporterVotes;
        if (voterCount * 7 <= 10 * total &&  66 * total <= 100 * pro) {
            return agendaByTitle[_title].result = status.passed;
        } else {
            return agendaByTitle[_title].result = status.failed;
        }
    }
    // 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function suggest(string calldata _title, string calldata _content) public {
        agendaByTitle[_title] = Agenda(agendaCount++, _title, _content, msg.sender, 0, 0, status.ongoing, block.number);
        voters[msg.sender].agendas.push(_title);
    }
    struct AgendaDetail {
        uint number;
        string title;
        string content;
        uint supporterVotes;
        uint opponentVotes;
    }
    // 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 
    // (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
    function checkMyAgendaStatus() public view returns(Agenda[] memory) {
        string[] memory _proposals = voters[msg.sender].agendas;
        Agenda[] memory res = new Agenda[](_proposals.length);

        for (uint i = 0; i < _proposals.length; i++) {
            res[i] = agendaByTitle[_proposals[i]];
        } // 상태 추가하기
        return res;
    }
}

contract BLOCK {
    constructor() {
        blockNumber = block.number;  // 0 (contract creation) 1st block
    }
    uint public blockNumber;
    function getBlockHash(uint _n) public view returns(bytes32) {
        return blockhash(_n);
    }
    function setBlockNumber() public {
        blockNumber = block.number;
    }
    function getBlockNumber() public view returns(uint) {
        return block.number; // 생성된 마지막 블록 넘버, 여기서 99를 뱉어낸다면, proposal의 시작점은 100으로 셋팅하는건 똑바로 된게 아니다. 
        // 100을 뱉어낸다면 그냥 100으로 해야해. 
    }
}