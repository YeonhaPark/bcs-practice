// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract A {
    uint public a;
    function setA(uint _a) public {
        a = _a;
    }
}

contract B {
    A a = new A();
    function setContractA(address _addr) public {
        a = A(_addr);
    }
    function setAOfA(uint _a) public {
        a.setA(_a);
    }
    function setAofAwithCall(uint _a) public returns(bytes memory) {
        (bool success, bytes memory data) = address(a).call(abi.encodeWithSignature("setA(uint256)", _a));
        require(success, "Failed"); // 보통 성공하면 data.length == 0 임.
        return data;
    }
    bytes4 private constant SELECTOR = bytes4(keccak256("setA(uint256)"));
    function setAofAwithCall2(uint _a) public returns(bytes memory) {
        (bool success, bytes memory data) = address(a).call(abi.encodeWithSelector(SELECTOR, _a));
        require(success, "Failed");
        return data;
    }
}