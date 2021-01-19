pragma solidity ^0.5.0;
import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";



contract UserFactory is ProxyFactory {
    
    
    address public implementationContract;
    mapping(address => address) public usercontract;
    address owner;
    uint usercount = 0;
    constructor (address _implementationContract) public {
        implementationContract = _implementationContract;
        owner = msg.sender;
    }
    
    function createUser(bytes memory _data) public {
        if(usercontract[address(msg.sender)] == address(0x0000000000000000000000000000000000000000))
        {
            address _proxy = deployMinimal(implementationContract, _data);
            usercontract[msg.sender] = _proxy;
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