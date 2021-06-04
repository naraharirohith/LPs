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

















    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    function stakeTokens(uint _amount) public {
        // Require amount greater than 0
        require(_amount > 0, "amount cannot be 0");

        // Trasnfer Mock Dai tokens to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        // Update staking balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        // Add user to stakers array *only* if they haven't staked already
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // Update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Unstaking Tokens (Withdraw)
    function unstakeTokens() public {
        // Fetch staking balance
        uint balance = stakingBalance[msg.sender];

        // Require amount greater than 0
        require(balance > 0, "staking balance cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);

        // Reset staking balance
        stakingBalance[msg.sender] = 0;

        // Update staking status
        isStaking[msg.sender] = false;
    }

    // Issuing Tokens
    function issueTokens() public {
        // Only owner can call this function
        require(msg.sender == owner, "caller must be the owner");

        // Issue tokens to all stakers
        for (uint i=0; i<stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0) {
                dappToken.transfer(recipient, balance);
            }
        }
    }
}