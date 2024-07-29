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
contract Drive {
    enum Status {
        stopped,
        driving,
        off
    }

    struct Car {
        uint speed;
        uint fuel;
        Status status;
    }
    Car public myCar;
    mapping(address => uint) gasPerAccount;

    receive()external payable {}

    modifier checkEngineStat() {
        require(myCar.status != Status.off);
        _;
    }
    function accelerate() public checkEngineStat {
        require(myCar.speed < 70 && myCar.fuel > 30, "Nope");
        myCar.speed += 10;
        myCar.fuel -= 20;
        if (myCar.status != Status.driving) {
            myCar.status = Status.driving;
        }
    }

    function checkIfPrepaid() public view returns(bool){
        if (gasPerAccount[msg.sender] >= 1 ether) {
            return true;
        } else {
            return false;
        }
    }

    function fillGas() public payable {
        require( myCar.status == Status.off);
        if (checkIfPrepaid()) {
            gasPerAccount[msg.sender] = gasPerAccount[msg.sender] - 1 ether;
        } else {
            require(msg.value >= 1 ether || address(this).balance >= 1 ether, "not enough ether");
            if (address(this).balance >= 1 ether) {
                payable(address(0)).transfer(1 ether);
                (bool success, ) = address(0).call{value: 1 ether}("");

            }
        }
        myCar.fuel = 100;
    }

    function speedDown() public checkEngineStat {
        require(myCar.speed > 0 && myCar.fuel >= 10 && (myCar.status == Status.driving), "Cannot break" );
        myCar.speed -= 10;
        myCar.fuel -= 10;
        if (myCar.speed == 0) {
            myCar.status = Status.stopped;
        }
    }

    function startEngine() public {
        require(myCar.status == Status.off, "Status not off");
        myCar.status = Status.stopped;

    }
    function startOffEngine() public {
        require(myCar.status == Status.stopped, "Must be stopped");
        myCar.status = Status.off;
    }
    // 충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감
    function prepay() public payable {
        gasPerAccount[msg.sender] = msg.value;
    }

}