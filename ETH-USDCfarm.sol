pragma solidity ^0.5.0;

import "./FakeRUSD.sol";
import "./FakeUSDC.sol";
import "./CDPmanager.sol";

contract TokenFarm {
    string public name = "Eth Token Farm";
    address public owner;
    FakeRUSD public rUSD;
    FakeUSDC public USDC;
    CDPmanager public cdplpToken;
    
    uint public userid;
    
    struct userinfo {
        uint cdplpToken;
        uint userid;
        uint amount1;
        uint amount2;
    }

    // Info of each user that stakes LP tokens.
    mapping(address => mapping(uint => userinfo)) public userinfos;
    
    // Info of each pool.
    struct poolInfo {
        //cdplpToken lpToken;   // Address of LP token contract.
        uint poolid;
        string poolName;
        //string supply1;
        //string supply2;
        //ratios need to be added
        uint totalamount1;
        uint totalamount2;
    }

    // Dev address.
    address public devaddr;
    
    // Info of each pool.
    poolInfo[] public poolInfos;
  
    
    constructor() public{
        userid = 0;
    }
    
    function poolLength() external view returns (uint256) {
        return poolInfos.length;
    }
    
    //function addPool(string supply1, string supply2) only owner{ }

    
    function liquidityProvider(uint poolId, uint _amount2) public payable returns(uint) {
        uint _amount1 = msg.value;
        
        //require(_amount1 > 0 && _amount2 > 0 , "amount cannot be zero");
        
        USDC.mint(msg.sender, 1000);
        USDC.transferFrom(msg.sender, address(this), _amount2);
        require(_amount1 == _amount2 * ethToUSDCRatio() , "Value of both the supplies should same");   // 1 Eth = 1 USDC * ethToUSDCRatio()
        poolInfos[1] = poolInfo(1, "ETH-USDC", 0, 0);
        poolInfos[1].totalamount1 += _amount1;
        poolInfos[1].totalamount2 += _amount2;
        
        userid++;
        
        rUSD.transferFrom(msg.sender, address(this), rUSDreceived());
        
        uint _lptokenId = cdplpToken.createlpToken("ETH-USDC" , rUSDreceived() , _amount2 , _amount1 , 150 , 200 );
        
        userinfos[msg.sender][userid] = userinfo(  _lptokenId  , userid , _amount1 , _amount2);
        
    }
    
    function ethToUSDCRatio() public returns(uint){
        return 10;
    }

    function rUSDreceived() public returns(uint) {
        return 100;
    }

}



