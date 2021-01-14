pragma solidity >=0.4.22 <0.8.0;
pragma experimental ABIEncoderV2;

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

contract UserTokenContract is Ownable{
     address[] tokenAddr;
     string[] tokenName;
     string[] tokenSymbol;
     string[] tokenImg;
     string[] color;
     uint tokenCount = 0;
     
       function initialize(address _owner) public  {
            Ownable(_owner);
  }
     function getAllTokens() public view returns(address[] memory,string[] memory,string[] memory,string[] memory,string[] memory, uint ){
         return(tokenAddr,tokenName,tokenSymbol,tokenImg,color,tokenCount);
     }
     function addToken(address _tokenAddr , string memory _tokenName, string memory _tokenSymbol, string memory _tokenImg, string memory _color) onlyOwner public {
         tokenAddr.push(_tokenAddr);
         tokenName.push(_tokenName);
         tokenSymbol.push(_tokenSymbol);
         tokenImg.push(_tokenImg);
         color.push(_color);
         tokenCount++;
         
     }
    
}