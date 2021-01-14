pragma solidity ^0.5.0;
import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";

contract Ownable {
  address public owner;

  constructor() internal{
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender == owner)
      _;
  }

   function transferOwnership(address newOwner) onlyOwner public{
    if (newOwner != address(0)) owner = newOwner;
  }

}

contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}

contract UserManager is Initializable, Ownable, ProxyFactory {
  string public name;

  function initialize(string memory _name, address _owner) public {
    Ownable(_owner);
    name = _name;
  }
      //mapping(address => address) public UserTokenContract;
    address public tokenImplementationContract;
    address public budgetImplementationContract;
    address public walletImplementationContract;
    address public UserBudgetContractAddr;
    address public UserWalletContractAddr;
    address public UserTokenContractAddr;
    
  
   constructor (address _tokenImp, address _budgetImp, address _walletImp) public {
    tokenImplementationContract = _tokenImp;
    budgetImplementationContract = _budgetImp;
    walletImplementationContract = _walletImp;
  }

  

    function createTokenContract(bytes memory _data) public onlyOwner{
        if(UserTokenContractAddr == address(0x0000000000000000000000000000000000000000))
        {
            
            UserTokenContractAddr = deployMinimal(tokenImplementationContract, _data);
        }
        else
        {
            revert("Contract already exists");
        }

    }
    function createBudgetContract(bytes memory _data) public onlyOwner{
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
    function createWalletContract(bytes memory _data) public onlyOwner{
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
        function getimp() public view returns (address){
        return tokenImplementationContract;
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