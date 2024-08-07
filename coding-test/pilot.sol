// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.19;
/**
시간 : 30분
학생이라는 구조체를 만드세요. 학생은 이름, 번호, 점수, 학점(A,B,C,D)으로 구성되어 있습니다.
학점은 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 나머지는 F입니다.  
학생들이 들어가는 array를 구현하고, 학생 정보를 넣는 함수, 정보를 받는 함수를 구현하세요.

필수 구현 기능 
* 학생 추가 기능 - 특정 학생의 정보를 추가
* 학생 정보 조회 기능 - 특정 학생의 정보를 조회
 */
contract TEST1 {
 struct Student {
    string name;
    uint number;
    uint8  score;
    string grade;
 }


Student[] students;
mapping(string=>Student) student_mapper;

 function setStudent(string memory _name, uint _number, uint8 _score) public {
    string memory _grade;
    if (_score >= 90) {
        _grade = 'A';
    } else if (_score >= 80) {
        _grade = 'B';
    } else if (_score >= 70) {
        _grade = 'C';
    } else {
        _grade = 'F';
    }
    Student memory _student = Student({name:_name, number:_number, score: _score, grade: _grade});
    students.push(_student);
 }

 function getStudents() public view returns(Student[] memory) {
    return students;
 }

 function getStudent(string memory _name) public view returns(Student memory) {
  for (uint i = 0; i < students.length; i++) {
    if (keccak256(abi.encodePacked(students[i].name)) == keccak256(abi.encodePacked(_name))) {
        return students[i];
    }
  }
  revert("No string matched");
 }
}