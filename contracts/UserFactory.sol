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



contract UserFactory is ProxyFactory, Ownable {
    
    
    address public implementationContract;
    mapping(address => address) public usercontract;
    uint usercount = 0;
    constructor (address _implementationContract) public {
        implementationContract = _implementationContract;
        Ownable(msg.sender);
    }
    
    function createUser(bytes memory _data) public {
        if(usercontract[address(msg.sender)] == address(0x0000000000000000000000000000000000000000))
        {
            address proxy = deployMinimal(implementationContract, _data);
            usercontract[msg.sender] = proxy;
            usercount++;
            
        }
        else
        {
            revert("user already exists");
        }

    }
      function getUserContractAddress(address _addr) public view returns (address){
        //address sender = msg.sender;
        //require(_addr == sender, "Access Denied: You Cant Access other peoples' contract");
        return usercontract[_addr];
    }
}