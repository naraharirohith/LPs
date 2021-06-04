pragma solidity 0.5.1;

contract CDPmanager {
    
    uint private lpId;
    
    address public owner;
    
    struct lpToken {
        uint tokenId;
        string tokenName;
        address owner;
        uint rUSD;
        uint USDC;
        uint eth;
        uint liqRatio;
        uint yeildRatio;
    }
    
    mapping(uint => lpToken) public lpTokens;
    
    constructor() public{
        lpId = 0;
        owner = msg.sender;
    }
    
    function createlpToken(string memory tokenName, uint _rUSD, uint _USDC,uint _eth, uint _liqRatio, uint _yeildRatio) public returns (uint){
        lpId++;
        
        require(_rUSD>0, "rUSD should be non zero");
        require(_USDC>0, "USDC should be non zero");
        require(_liqRatio>=150, "Liquidation ratio should be greater than 150");
        
        lpTokens[lpId] = lpToken(lpId, tokenName,owner, _rUSD, _USDC, _eth, _liqRatio, _yeildRatio);
        
        return lpId;
    }
    
    //function mintlptoken(uint _lpId) public {  }
    
}