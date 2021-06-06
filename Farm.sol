pragma solidity ^0.5.0;

import "./FakeRUSD.sol";
import "./FakeUSD.sol";
import "./CDPmanager.sol"

contract TokenFarm {
    string public name = "Eth Token Farm";
    address public owner;
    FakeRUSD public rUSD;
    FakeUSDC public USDC;
    CDPmanager public cdplpToken;
    
    uint public userid;

    
    // Info of each pool.
    struct PoolInfo {
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
    PoolInfo[] public poolInfos;
    
    // Info of each user that stakes LP tokens.
    mapping(address => (userid => lptokenId)) public userinfo;
    
    
    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }
    
    //function addPool(string supply1, string supply2) only owner{ }
    poolinfos[1] = poolInfo(1, "ETH-USDC" , 0,0)
    
    function liquidityProvider(uint poolId, string "ETH-USDC", uint _amount2) public payable {
        amount1 = msg.value;
        
        require(_amount1 > 0 && _amount2 > 0 , "amount cannot be zero");
        
        USDC.transferFrom(msg.sender, address(this), _amount2);
        require(_amount1 == _amount2 * ethToUSDCRatio() , "Value of both the supplies should same");   // 1 Eth = 1 USDC * ethToUSDCRatio()
        
        poolinfos[1].
        
        
        
    }
    
    function ethToUSDCRatio() public return(uint){
        return 10;
    }

