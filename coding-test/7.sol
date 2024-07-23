// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/*
        
악셀 기능 - 속도를 10 올리는 기능, 악셀 기능을 이용할 때마다 연료가 20씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 속도가 70이상이면 악셀 기능은 더이상 못씀
주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨
브레이크 기능 - 속도를 10 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 10씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
--------------------------------------------------------
충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감
*/
contract Car {
    uint public speed;
    uint public fuel;
    Status public status = Status.off;
    enum Status {
        stopped,
        driving,
        neutral,
        reverse,
        off
    }

    mapping(address => uint) gasPerAccount;

    modifier checkEngineStat() {
        require(status != Status.off);
        _;
    }
    function accelerate() public checkEngineStat {
        require(speed < 70, "Speed permit until 69");
        require(fuel > 30, "No fuel left");
        speed += 10;
        fuel -= 20;
    }

    function checkIfPrepaid() public view returns(bool){
        if (gasPerAccount[msg.sender] >= 1 ether) {
            return true;
        } else {
            return false;
        }
    }

    function fillGas() public payable {
        if (checkIfPrepaid()) {
            gasPerAccount[msg.sender] = gasPerAccount[msg.sender] - 1 ether;
        } else {
            require(msg.value >= 1 ether, "not enough ether");
        }
        fuel = 100;
    }

    function speedDown() public checkEngineStat {
        require(speed > 0, "Cannot break");
        speed -= 10;
        fuel -= 10;
    }

    function startEngine() public {
        status = Status.stopped;

    }
    function startOffEngine() public {
        require(speed == 0, "Speed not zero");
        status = Status.off;
    }
    // 충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감
    function prepay() public payable {
        gasPerAccount[msg.sender] = msg.value;
    }

}