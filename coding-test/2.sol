// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/*
    학생 점수관리 프로그램입니다.
    여러분은 한 학급을 맡았습니다.
    학생은 번호, 이름, 점수로 구성되어 있고(구조체)
    가장 점수가 낮은 사람을 집중관리하려고 합니다.

    가장 점수가 낮은 사람의 정보를 보여주는 기능,
    총 점수 합계, 총 점수 평균을 보여주는 기능,
    특정 학생을 반환하는 기능, -> 학생정보로 반환
    가능하다면 학생 전체를 반환하는 기능을 구현하세요. ([] <- array)
 */

contract Marker {
    struct Student {
        uint number;
        string name;
        uint score;
    }

    Student[] public students;
    mapping(string => Student) private studentMapping;

    function addStudent(uint _number, string memory _name, uint _score) public {
        Student memory newStudent = Student(_number, _name, _score);
        students.push(newStudent);
        studentMapping[_name] = newStudent;
    }

    function getLowest() public view returns(Student memory) {
        uint lowestScore = 100;
        Student memory lowestStudent;
        for (uint i = 0; i < students.length; i++) {
             if (students[i].score < lowestScore) {
                lowestScore = students[i].score;
                lowestStudent = students[i];
             }
        }
        return lowestStudent;
    }

    function getTotalSum() public view returns(uint) {
        uint sum = 0;
        for (uint i = 0; i < students.length; i++) {
            sum += students[i].score;
        }
        return sum;
    }

    function getAverage() public view returns(uint) {
        return getTotalSum() / students.length;
    }

    function getStudent(string memory _name) public view returns(Student memory) {
        require(bytes(studentMapping[_name].name).length != 0, "Student not found");
        return studentMapping[_name];
    }


    function getStudents() public view returns(Student[] memory){
        return students;
    }
}