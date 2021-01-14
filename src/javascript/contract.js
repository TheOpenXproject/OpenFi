import Wallet from "./wallet";
import hmy from "./hmy";
const { BN } = require("@harmony-js/crypto");
const { toWei } = require("@harmony-js/utils");
var fs = require("fs");

let but = document.getElementById("loginButton");

but.addEventListener("click", initWallet);

async function initWallet() {
  const wallet = new Wallet();
  await wallet.signin();

  const one = new BN("1");
  let options = {
    gasPrice: 1000000000,
    gasLimit: 210000
  };

  const unattachedContract = await initializeContract();
  const contract = wallet.attachToContract(unattachedContract);
  const value = await contract.methods.createUser().send(options);
  console.log("hello :", value.toString());
}

const initializeContract = async wallet => {
  let contract = fs.readFileSync("../../../../build/contracts/User.json", {
    encoding: "UTF-8"
  });
  contract = JSON.parse(contract);
  const abi = contract.abi;
  const contractAddress = "0x3B9D6013CEe20e7C50A1b8223b810Bb550fb5Aa9";
  const contractInstance = hmy.contracts.createContract(abi, contractAddress);
  return contractInstance;
};

const show = document.getElementById("Export");
show.addEventListener("click", showValue);

async function showValue() {
  const one = new BN("1");
  let options = {
    gasPrice: 1000000000,
    gasLimit: 210000
  };
  const wallet = new Wallet();
  await wallet.signin();
  const unattachedContract = await initializeContract();
  const contract = wallet.attachToContract(unattachedContract);
  const value = await contract.methods.getContractAddr().call();
  console.log(value.toString());
}
