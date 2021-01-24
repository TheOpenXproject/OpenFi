const Migrations = artifacts.require("Migrations");
const userFactory = artifacts.require("UserFactory");
const userManager = artifacts.require("UserManager");

const userWallet = artifacts.require("UserWalletContract");

const userBudget = artifacts.require("UserBudgetContract");

const userToken = artifacts.require("UserTokenContract");

//const User = artifacts.require("User");

module.exports = async function (deployer) {
  deployer.deploy(Migrations);

 //  await deployer.deploy(userWallet)

 // 		await deployer.deploy(userBudget)

 // 		await deployer.deploy(userToken)

//await deployer.deploy(userManager)
  await deployer.deploy(userFactory)

  
  .then(
  	async function () {
 	//	console.log(`   address public budgetImplementationContract = ${userWallet.address};\n`);
 	//	console.log(`   address public walletImplementationContract = ${userBudget.address};\n`);
 	//	console.log(`   address public tokenImplementationContract = ${userToken.address};\n`);
  	//	console.log(`   export USERMANAGER=${userManager.address};\n`);
  		console.log(`   export USERFACTORY=${userFactory.address};\n`);

  	})
  //deployer.deploy(User);
};
