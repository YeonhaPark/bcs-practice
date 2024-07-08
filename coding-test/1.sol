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

/*
여러분은 선생님입니다. 학생들의 정보를 관리하려고 합니다. 
학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들이 포함되어야 합니다. OK

번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다.

학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.

필요한 기능들은 아래와 같습니다.

* 학생 추가 기능 - 특정 학생의 정보를 추가 OK
* 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환 OK
* 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환 OK
* 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환 OK
* 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환 OK
* 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환 OK
* 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환 OK
* 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환 OK
* 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환 OK
-------------------------------------------------------------------------------
* S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)

기입할 학생들의 정보는 아래와 같습니다.

Alice, 1, 85
Bob,2, 75
Charlie,3,60
Dwayne, 4, 90
Ellen,5,65
Fitz,6,50
Garret,7,80
Hubert,8,90
Isabel,9,100
Jane,10,70
*/

contract TEST2 {
    struct Student { // 1) 
        string name;
        uint8 number;
        uint8 score;
        string grade;
    }

    Student[] students;

    mapping(string => uint8) studentScore;
    mapping(uint8 => Student) studentInfoByNumber;
    mapping(string => Student) studentInfoByName;

    /**
     * 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 
     */
    function getGrade(uint8 _score) public pure returns(string memory) {
        if (_score >= 90) {
            return 'A';
        } else if (_score >= 80) {
            return 'B';
        } else if (_score >= 70) {
            return 'C';
        } else if (_score >= 60) {
            return 'D';
        } else {
            return 'F';
        }
    }
    /**
     * 학생 추가 기능 - 특정 학생의 정보를 추가
     */
    function addStudent(string memory _name, uint8 _score) public {
            string memory grade = getGrade(_score);
            students.push(Student(_name, uint8(students.length + 1), _score, grade));
    }
    
    /**
     * 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
     */
    function getStudentInfoByNumber(uint8 _number) public view returns(Student memory){
        for (uint i = 0; i < students.length; i++) {
            if (students[i].number == _number) {
                return students[i];
            }
        }
        revert("Student not found");
    }

    /**
     * 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
     */
    function getStudentInfoByName(string memory _name) public view returns(Student memory) {
        for (uint i = 0; i < students.length; i++) {
            if (keccak256(abi.encodePacked(students[i].name)) == keccak256(abi.encodePacked(_name))) {
                return students[i];
            }
        }
        revert("Student not found");
    }

    /**
    * 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    */
    function getStudentScoreByName(string memory _name) public view returns(uint8) {
        Student memory info = getStudentInfoByName(_name);
        return info.score;
    }


    /**
     * 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
     */
    function getStudentNumbers() public view returns(uint) {
        return students.length;
    }

    /**
     * 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
     */
    function getStudents() public view returns(Student[] memory) {
        return students;
    }

    /**
     * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
     */
    function getAverage() public view returns(uint) {
        uint average;
        for (uint i = 0; i < students.length; i++) {
            average += students[i].score;
        }
        return average / students.length;
    }

    /**
     * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
     */
    function testTeacher() public view returns(bool) {
        uint average = getAverage();
        return average >= 70 ? true : false;
    }
}