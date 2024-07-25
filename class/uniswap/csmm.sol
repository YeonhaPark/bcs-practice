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
    function addLiquidity(uint _n) public { 
        (uint bal_a, uint bal_b) = getCurrentBal();

        // lp. token 뽑아가는 방법 생각해보기.
        // (bool success1, bytes memory data1) = address(token_A).call(abi.encodeWithSignature("transfer(address,uint256)", _n));
        // (bool success2, bytes memory data2) = address(token_B).call(abi.encodeWithSignature("transfer(address,uint256)", _n));

        token_A.transferFrom(msg.sender,address(this), _n); // user에게서 돈을 빼워야 하기 때문에 받을때, 돌려줄때 쓰는 함수가 다름. erc20 코드 읽어보기.
        token_B.transferFrom(msg.sender,address(this), _n);
        uint total = totalSupply(); // lp token의 갯수
        if (total > 0) {
            //    100, 80 가 있고 lp 는 50개가 있어. -> 20, 20 더 넣을래
            // 40 * 50 / 180   = 200 / 180 
            _mint(msg.sender, _n * 2 * total / (bal_a + bal_b)); // 선정할때 mint, 투표할때 burn.
        } else { // 최초 유동자
            _mint(msg.sender, _n * 2); // lp 1개 == a == b  가격 다 같음.
            // lp token은 tx가 일어나면 자연스럽게 가치가 축적되서 채권이랑 비슷. 
            // lp token을 담보로 대출하는것도 생겨남. 담보 대비 대출 비율(LTV) 
            // dti 사업자 대출(신용대출)은 과담보 대출인가? 적정대출인가? 즉, 담보 대출에 대해 더 많은 금액을 빌려주는가?
            // 보통 과담보대출이다. 다 미래 현금을 끌어와서 계산하는것은 맞다. 담보가 거의 없는데 신용을 가지고 빌려줌.
            // 100을 맡기더라도 150을 빌려줄 수 있다면? 
            // 이를 시도하는 방법 중 성공한게 lp token을 이용한 
            // 100 만원을 갖고 있고 lp token 이자율이 48% 을 받을 수 있다면,? 20만원 빌려주고 일년 후 2배로 받을 수 있으니까
            // 대시보드, 지갑 관련된 금액이 얼마를 갖고 있는지 알려주는 애들 ex. debank

            // liquidity pool 내에 200, 280 => 480 개를 lp 토큰 받을 수 있음.
            // 내가 50개 lp token을 주고 유동성을 회수한다면 a, b를 몇개 받을까? 25, 25
        }
    } 
    function withdrawLiquidity(uint _n) public { // burn
        // lp token은 burn. liquidity lp를 liquidity pool 에 주는 것 아닙니다. 그렇게 되면 lp token 홀드한사람들의 lp token value가 떨어집니다.
        // 유동성은 줄었는데, lptoken total supply가 같으면 기존 홀더가 갖고있는 토큰의 가치가 낮아집니다.
        _burn(msg.sender, _n);
        token_A.transfer(msg.sender, _n / 2);
        token_B.transfer(msg.sender, _n / 2);
    } 

    function swap(address _addr, uint _amount) public {
        require(_addr == address(token_A) || _addr == address(token_B), "nope");
        bool isA = _addr == address(token_A);
        if (isA) { // a 판매 in, b 구매 out
            token_A.transferFrom(msg.sender,address(this), _amount);
            token_B.transfer(msg.sender, _amount * 99 / 10);
        } else {
            token_B.transferFrom(msg.sender,address(this), _amount); // 돈 받고 줘라.
            token_A.transfer(msg.sender, _amount * 99 / 100);
        }
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