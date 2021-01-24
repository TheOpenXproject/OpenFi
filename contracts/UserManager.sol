pragma solidity ^0.5.0;
//import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";
import "./UserBudgetContract.sol";
import "./UserWalletContract.sol";
import "./UserTokenContract.sol";


contract UserManager{
  address public owner;

  address public UserBudgetContractAddr;
  address public UserWalletContractAddr;
  address public UserTokenContractAddr;

  function getContractAddr() public view returns (address){
    return address(this);
  }
  
  function createTokenContract() public {
    if(UserTokenContractAddr == address(0x0000000000000000000000000000000000000000))
    {
            UserTokenContract newUserContract = new UserTokenContract();
            UserTokenContractAddr = newUserContract.getContractAddr();
    }
    else
    {
      revert("Contract already exists");
    }

  }
  function createBudgetContract() public {
    if(UserBudgetContractAddr == address(0x0000000000000000000000000000000000000000))
    {
            UserBudgetContract newBudgetContract = new UserBudgetContract();
            UserBudgetContractAddr = newBudgetContract.getContractAddr();
    }
    else
    {
      revert("Contract already exists");
    }

  }
  function createWalletContract() public {
    if(UserWalletContractAddr == address(0x0000000000000000000000000000000000000000))
    {
            UserWalletContract newWalletContract = new UserWalletContract();
            UserWalletContractAddr = newWalletContract.getContractAddr();
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