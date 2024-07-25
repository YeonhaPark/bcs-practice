1.  주소가 있는데, 주소가 sc를 여러개 배포, 내가 찾고 있는 sc가 무었인지 까먹,, 내가 function 이름만 기억이 난다?
    contract creation tx -> method id ?

filter:
calldata가 존재하는거
data의 맨 앞자리 60806040
내가 만든 tx 중에 contract creation 뽑아내기
받는 SC 주소 정렬 후 events에 내가 원하는 event id가 존재하는 형식으로 하면 된다.

2.  CSMM, CPMM
    CSMM: x + y = k
    CPMM: Constant Product Market Makers : x \* y = k
    매우 간단한 swap 만들어 보기.

토큰 갯수 변화 관점에서 둘의 차이 ?
CPMM은 특젙 토근의 갯수가 0이 안되고 CSMM는 됨
CPMM 접선의 기울기 계속 변함(가격이 계속 변함)) CSMM -1

uniswap같은 경우 tx fee 를 몇개 걷음? 0.3% 걷음.
a를 팔아서 b를 100개 받아가야된다. tx fee 땜에 99.7개를 준다. 0.3개는 lilquidity pool 안에 머뭄. 이게 lp token의 가치에 녹아들어서. lptoken 소유권의 갯수가 늘어난다.

실습은 Fee를 없앤 상태에서 할거임

그 다음은 Fee 를 켜서 할 거임. 이러면 들어오는건 똑같고 나가는건 조금 줄어들겠지?

liquidity pool 자체도 erc20. pool token은 유동성 제공 시 받고(mint), 유동생 뺄 때 burn.
