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
전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각 
 */

contract Reunion {
    struct Agenda {
        uint number;
        string title;
        string content;
        address raisedBy;
        uint supporterVotes;
        uint opponentVotes;
    }

    struct Voter {
        string name;
        address addr;
        Agenda[] agendas;
        Agenda[] votedFor;
        mapping(string => bool) voteResult;
    }
    Agenda[] allAgendas;
    mapping(string => Agenda) agendaByTitle;
    mapping(address => Agenda) agendaByAddr;
    mapping(address => Agenda[]) agendasByAddr;
    mapping(address => Voter) voters;
    enum Status {
        ONGOING,
        PASSED,
        DISMISSED
    }

    // 사용자 등록 기능 - 사용자를 등록하는 기능
    function registerVoter(string memory name, address addr) public {
        voters[addr].name = name;
        voters[addr].addr = addr;
    }


    // 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
    function getAgenda(string memory title) public view returns(Agenda memory) {
        return agendaByTitle[title];
    }
    // 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function voteFor(string memory title, bool vote) public view {
        // 내가 투표한 아젠다 -> agendasByAddr[msg.sender].votedFor 가  agendaByTitle[title을 포함하면 안됨
        bool alreadyVoted;
        for (uint i = 0; i < agendasByAddr[msg.sender].length; i++) {
            if (keccak256(abi.encodePacked(agendasByAddr[msg.sender][i].title)) == keccak256(abi.encodePacked(agendaByTitle[title].title))) {
                alreadyVoted = true;
                break;
            }
        }
        if (alreadyVoted) {
            revert("You already voted for this agenda");
        }
        Agenda memory agendaToVote = getAgenda(title);
        vote ? agendaToVote.supporterVotes++ : agendaToVote.opponentVotes++;
    }
    // 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function suggest(string memory title, string memory content) public {
        uint agendaNumber = allAgendas.length;
        Agenda memory newAgenda = Agenda(agendaNumber + 1, title, content, msg.sender, 0, 0);
        allAgendas.push(newAgenda);
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
    function checkMyAgendaStatus(address myAddress) public view returns(AgendaDetail[] memory) {
        Agenda[] memory myAgenda = agendasByAddr[myAddress];
        AgendaDetail[] memory myAgendaDetails = new AgendaDetail[](myAgenda.length);
        for (uint i = 0; i < myAgenda.length; i++) {
            myAgendaDetails[i] = AgendaDetail(myAgenda[i].number, myAgenda[i].title, myAgenda[i].content, myAgenda[i].supporterVotes, myAgenda[i].opponentVotes);
        } // 상태 추가하기
        return myAgendaDetails;
    }


    // 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 
    // 15개 블록 후에 전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
    function progress(string memory title) public view returns (Status){
        Status currentStatus = Status.ONGOING;
        return currentStatus;
    }

}
