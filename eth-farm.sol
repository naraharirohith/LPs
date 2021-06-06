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
    
    address[] public LPproviders;
    mapping(address => uint) public poolUSDCBalance;
    mapping(address => uint) public poolEthBalance;
    mapping(address => uint) public rUSDreceived;
    mapping(address => bool) public hasprovided;
    mapping(address => bool) public isproviding;
    
    uint public totalValueOfPool;
    
    constructor(FakeRUSD _rUSD, FakeUSDC _USDC) public {
        rUSD = _rUSD;
        USDC = _USDC;
        owner = msg.sender;
        totalValueOfPool = 0;
    }

    function LPProvide(uint _amount1) public payable {
        uint _amount2 = msg.value;
        // Require amount greater than 0
        require(_amount1 > 0 && _amount2 > 0 , "amount cannot be 0");
        require( (_amount1/_amount2) == ethToUSDCRatio() , "Value of eth and USDC should be same(According to current USD)");

        // Trasnfer Mock FakeUSDC to this contract to lending Pool
        USDC.transferFrom(msg.sender, address(this), _amount1);

        // Update providing balance
        poolUSDCBalance[msg.sender] = poolUSDCBalance[msg.sender] + _amount1;
        poolEthBalance[msg.sender] = poolEthBalance[msg.sender] + _amount2;
        

        // Add user to provider array *only* if they haven't provided already
        if(!hasprovided[msg.sender]) {
            LPproviders.push(msg.sender);
        }

        // Update provider status
        isproviding[msg.sender] = true;
        hasprovided[msg.sender] = true;
        
        rUSD.transferFrom(this(address), msg.sender, resultingrUSD());
        rUSDreceived[msg.sender] += resultingrUSD();
    
        totalValueOfPool += _amount2 * ethToUSD();
        totalValueOfPool += _amount1 * USDCtoUSD();
        
    }
    
    function retriveTokens() public {
        // Fetch provider balance
        uint balance1 = poolUSDCBalance[msg.sender];
        uint balance2 = poolEthBalance[msg.sender];
 
        // Require amount greater than 0
        require(balance1 > 0 && balance2 >0, "balances cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        rUSD.transferFrom(msg.sender,address(this), rUSDreceived[msg.sender]);

        USDC.transferFrom(address(this) , msg.sender , balance1);
        poolUSDCBalance[msg.sender] -= balance1;
        require(msg.sender.trasnfer(balance2) , "transaction should happen");
        poolEthBalance[msg.sender] -= balance2;

        // Update providing status
        isproviding[msg.sender] = false;
        
        totalValueOfPool -= balance1 * USDCtoUSD();
        totalValueOfPool -= balance2 * ethToUSD();
    }
    
    function ethToUSDCRatio() public returns(uint){
        return 10;
    }
    
    function resultingrUSD() public returns(uint){
        return 66;
    }
    
    function ethToUSD() public returns(uint){
        //eth price in USD
        return 2500;
    }
    
    function USDCtoUSD() public returns(uint){
        return 75;
    }
    
    //function returnsToProviders() public { }
    
}



