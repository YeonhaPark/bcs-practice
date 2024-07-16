// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
/**
숫자를 시분초로 변환하세요.
예) 100 -> 1 min 40 sec
600 -> 10min 
1000 -> 16min 40sec
5250 -> 1hour 27min 30sec
 */

contract TimeConverter {
    function convertToTime(uint256 totalSeconds) public pure returns (string memory) {
        uint256 h = totalSeconds / 3600;
        uint256 m = (totalSeconds % 3600) / 60;
        uint256 s = totalSeconds % 60;

        string memory hourStr = h > 0 ? string(abi.encode(h, " hour ", h == 1 ? "" : "s ")) : "";
        string memory minuteStr = m > 0 ? string(abi.encode(m, " min ")) : "";
        string memory secondStr = s > 0 ? string(abi.encode(s, " sec")) : "";

        return string(abi.encode(hourStr, minuteStr, secondStr));
    }

}
