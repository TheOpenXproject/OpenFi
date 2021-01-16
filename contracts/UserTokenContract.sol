pragma solidity >=0.4.22 <0.8.0;
pragma experimental ABIEncoderV2;






contract UserTokenContract {
     address owner;
     address[] tokenAddr;
     string[] tokenName;
     string[] tokenSymbol;
     string[] tokenImg;
     string[] color;
     uint tokenCount = 0;
     
         function getContractAddr() public view returns (address){
        
        return address(this);
    }
           function initialize(address _owner) public  {
            owner = _owner;
  }
     function getAllTokens() public view returns(address[] memory,string[] memory,string[] memory,string[] memory,string[] memory, uint ){
         return(tokenAddr,tokenName,tokenSymbol,tokenImg,color,tokenCount);
     }
     function addToken(address _tokenAddr , string memory _tokenName, string memory _tokenSymbol, string memory _tokenImg, string memory _color) public {
         tokenAddr.push(_tokenAddr);
         tokenName.push(_tokenName);
         tokenSymbol.push(_tokenSymbol);
         tokenImg.push(_tokenImg);
         color.push(_color);
         tokenCount++;
         
     }
    
}