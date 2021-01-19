pragma solidity ^0.5.0;
import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";




contract UserManager is ProxyFactory{
  string public name;
  address public owner;


  function initialize(address _owner) public {
    owner = _owner;
  }


   address public budgetImplementationContract = 0x7bae5CAA64C56f6cae072c9Ba228B4955b76E6C3;

   address public walletImplementationContract = 0x473CE089c80244953e376d81F76E5B3DDDCD73e8;

   address public tokenImplementationContract = 0x08157480C1FC7e480b0eaDa4797939AE2Dcd0a11;




  address public UserBudgetContractAddr;
  address public UserWalletContractAddr;
  address public UserTokenContractAddr;

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