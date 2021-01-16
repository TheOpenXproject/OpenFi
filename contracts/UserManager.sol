pragma solidity ^0.5.0;
import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";
import "@openzeppelin/upgrades/contracts/ownership/Ownable.sol";
import "./UserTokenContract.sol";
import "./UserBudgetContract.sol";
import "./UserWalletContract.sol";




contract UserManager is ProxyFactory{
  string public name;
  address public owner;
    modifier onlyOwner() {
    if (msg.sender == owner)
      _;
  }

  function initialize(string memory _name, address _owner) public {
    owner = _owner;
    name = _name;
  }
      //mapping(address => address) public UserTokenContract;
       address public budgetImplementationContract = 0x9641e9d459b8C62af4F9230C95C0C5f8f1c547d0;

   address public walletImplementationContract = 0xecA286C2A04aD444BBc550018352BA58b514eb6c;

   address public tokenImplementationContract = 0xf862850E338Cb29AE392151f6661257D7252f643;

    address public UserBudgetContractAddr;
    address public UserWalletContractAddr;
    address public UserTokenContractAddr;
    
    function DeployContracts(bytes memory _data) public {
        createTokenContract(_data);
        createBudgetContract(_data);
        createWalletContract(_data);

  }
     function getContractAddr() public view returns (address){
      
      return address(this);
  }
  function createTokenContract(bytes memory _data) public {
      if(UserTokenContractAddr == address(0x0000000000000000000000000000000000000000))
      {
          address _proxy = deployMinimal(tokenImplementationContract, _data);
          UserTokenContractAddr = _proxy;
      }
      else
      {
          revert("Contract already exists");
      }

  }
  function createBudgetContract(bytes memory _data) public {
      if(UserBudgetContractAddr == address(0x0000000000000000000000000000000000000000))
      {
          address _proxy = deployMinimal(budgetImplementationContract, _data);
          UserBudgetContractAddr = _proxy;
      }
      else
      {
          revert("Contract already exists");
      }

  }
  function createWalletContract(bytes memory _data) public {
      if(UserWalletContractAddr == address(0x0000000000000000000000000000000000000000))
      {
          address _proxy = deployMinimal(walletImplementationContract, _data);
          UserWalletContractAddr = _proxy;
      }
      else
      {
          revert("Contract already exists");
      }

  }
    function getUserTokenContractAddress() public view returns (address){
        return UserTokenContractAddr;
    }
    function getUserBudgetContractAddress() public view returns (address){
        return UserBudgetContractAddr;
    }
    function getUserWalletContractAddress() public view returns (address){
        return UserWalletContractAddr;
    }
  
  
}