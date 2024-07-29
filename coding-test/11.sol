// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;
/*
로또 프로그램을 만드려고 합니다. 
숫자와 문자는 각각 4개 2개를 뽑습니다. 6개가 맞으면 1이더, 5개의 맞으면 0.75이더, 
4개가 맞으면 0.25이더, 3개가 맞으면 0.1이더 2개 이하는 상금이 없습니다. 

참가 금액은 0.05이더이다.

예시 1 : 8,2,4,7,D,A
예시 2 : 9,1,4,2,F,B
*/

contract Lottery {
    address owner;
    constructor() {
        owner = msg.sender;
    }
    mapping(address=>uint) balance;
    uint lastCalledTime;

    function generateRandomPicks() public view returns(bytes memory) {
        bytes memory lotteryAnswer = new bytes(6);

        for (uint i = 0; i < 4; i++) {
            uint random = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender, i))) % 10;
            lotteryAnswer[i] = bytes1(uint8(0x30 + random));
        }
        for (uint i = 4; i < 6; i++) {
        uint randomStr = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender, i))) % 26;
            lotteryAnswer[i] = bytes1(uint8(0x41 + randomStr)); 

        }
        return lotteryAnswer;
    }
    function answer() public returns(bytes memory) {
        require(msg.sender == owner, "only owner");
        generateRandomPicks();
        lastCalledTime = block.timestamp;
    }
    function strToBytes(string memory str) public pure returns(bytes memory) {
        return bytes(str);
    }
    function start(uint num1, uint num2, uint num3, uint num4, string memory str1, string memory str2) public {
        // 6532AB
        // 숫자: 0x30 ~ 0x39, 문자: 0x41 ~ 5A
        require(lastCalledTime + 60 * 60 * 24 * 7 <= block.timestamp, "time not passed");
        bytes memory aim = generateRandomPicks();
        lastCalledTime = block.timestamp;
        bytes memory given = new bytes(6);
        given[0] =  bytes1(uint8(0x30 + num1));
        given[1] =  bytes1(uint8(0x30 + num2));
        given[2] =  bytes1(uint8(0x30 + num3));
        given[3] =  bytes1(uint8(0x30 + num4));
        bytes memory str1Bytes = bytes(str1);
        bytes memory str2Bytes = bytes(str2);
        require(str1Bytes.length > 0, "str1 is empty");
        require(str2Bytes.length > 0, "str2 is empty");
    
        given[4] = str1Bytes[0];
        given[5] = str2Bytes[0];

        for (uint i = 0; i < 6; i++) {
            require(aim[i] == given[i], "Wrong");
        }

    }
    function deposit() public payable {
        balance[msg.sender] += msg.value;
        require(balance[msg.sender] >= 0.5 ether, "Required more than 5 ether");
    }
}