// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CSMM is ERC20("Lion_Liquidity", "LL") { // swap이 이뤄지는 곳, 유동성이 쌓이는 곳 같은 SC.
    IERC20 token_A;
    IERC20 token_B;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    constructor(address _token_A, address _token_B) {
        token_A = IERC20(_token_A);
        token_B = IERC20(_token_B);
    }

    function getCurrentBal() public view returns(uint, uint) {
        uint bal_a = token_A.balanceOf(address(this));
        uint bal_b = token_A.balanceOf(address(this));
        return (bal_a, bal_b);
    }

    // mint
    function addLiquidity(address _addr, uint _n) public {
        require(_addr == address(token_A) || _addr == address(token_B), "nope");
        (uint a, uint b) = getCurrentBal();
        bool isA = address(token_A) == _addr;
        uint total = totalSupply();
        if (isA) {
            uint _in = a * _n / b; // _n에  a / b 비율을 곱해준 것
            token_A.transferFrom(msg.sender,address(this), _n);
            token_B.transferFrom(msg.sender,address(this), _in);
            _mint(msg.sender,  total * _n / a);

        } else {
            uint _in = b * _n / a; // _n에  b / a 비율을 곱해준 것
            token_A.transferFrom(msg.sender,address(this), _in);
            token_B.transferFrom(msg.sender,address(this), _n);
            _mint(msg.sender,  total * _n / b);

        }
        // 풀 안에 a 100 b 500, _addr은 토큰 어드레스  
        // 맨 처음에 넣는 사람이 가격을 결정 token 3000, usdt 9000 넣으면 3 달러에 시작하겠다는 것.
        // a, b token 가격비 정하기.

        // 100, 500 에서 a + 15 하자면, b는 75개 넣으면 됌.
    }
    function withdrawLiquidity(uint _n) public { // burn
      
    } 

    function swap(address _addr, uint _amount) public {
       
    }
}

contract Token_A is ERC20("A token", "A") {
    function mint() public {
        _mint(msg.sender, 100);
    }
}

contract Token_B is ERC20("B token", "B") {
    function mint() public {
        _mint(msg.sender, 100);
    }
}