pragma solidity ^0.5.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MoonDust is ERC20 {
    uint256 totalSupply_ = 100000000000000000000000;
    string public constant name = "Moondust";
	string public constant symbol = "MooD";
	uint8 public constant decimals = 18;

	mapping(address => uint256) balances;
	mapping(address => mapping (address => uint256)) allowed;
    address owner;

    constructor() public ERC20() {
        owner = msg.sender;
 
   		balances[msg.sender] = totalSupply_;
        

    }
    function totalSupply() public view returns (uint256) {
 	 return totalSupply_;
	}

	function balanceOf(address tokenOwner) public view returns (uint) {
	  return balances[tokenOwner];
	}

	function transfer(address receiver,
                 uint numTokens) public returns (bool) {
  require(numTokens <= balances[msg.sender]);
  balances[msg.sender] = balances[msg.sender] - numTokens;
  balances[receiver] = balances[receiver] + numTokens;
  emit Transfer(msg.sender, receiver, numTokens);
  return true;
}
function approve(address delegate,
                uint numTokens) public returns (bool) {
  allowed[msg.sender][delegate] = numTokens;
  emit Approval(msg.sender, delegate, numTokens);
  return true;
}
function allowance(address owner,
                  address delegate) public view returns (uint) {
  return allowed[owner][delegate];
}

}