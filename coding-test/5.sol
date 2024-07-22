// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";
/**
숫자를 시분초로 변환하세요.
예) 100 -> 1 min 40 sec
600 -> 10min 
1000 -> 16min 40sec
5250 -> 1hour 27min 30sec
 */

contract Base {
    function s_concat(string memory _a, string memory _b) public pure returns(string memory) {
        return string.concat(_a, _b);
    }
}

contract TimeConverter {
    function getHMS(uint256 totalSeconds) public pure returns (uint,uint,uint) {
        uint256 h = totalSeconds / 3600;
        uint256 m = (totalSeconds % 3600) / 60;
        uint256 s = totalSeconds % 60;

        return (h, m, s);
    }
    function convert(uint256 totalSeconds) public pure returns (string memory) {
        (uint a, uint b, uint c) = getHMS(totalSeconds);
        return string(abi.encodePacked(Strings.toString(a), " hours ", Strings.toString(b), " minutes ", Strings.toString(c), " seconds"));
    }

}
