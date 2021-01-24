pragma solidity ^0.5.0;
//import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-sdk/blob/master/packages/lib/contracts/upgradeability/ProxyFactory.sol";
import "./UserManager.sol";

contract UserFactory{
    
    
    mapping(address => address) public usercontract;
    address owner;
    uint usercount = 0;
    
    constructor () public {
        owner = msg.sender;
    }
    

    function createUser() public {
        if(usercontract[address(msg.sender)] == address(0x0000000000000000000000000000000000000000))
        {
            UserManager newManagerContract = new UserManager();
            usercontract[address(msg.sender)] = newManagerContract.getContractAddr();
            usercount++;
            
        }
        else
        {
            revert("user already exists");
        }

    }
      function getUserContractAddress(address _addr) public view returns (address){
        //require(msg.sender == owner, "Access Denied: You Cant Access other peoples' contract");
        return usercontract[_addr];
    }
}