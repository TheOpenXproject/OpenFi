<template>
  <div class="createAccount">
    <div class="text-center">
      <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            color="green darken-1"
            width="100%"
            dark
            v-bind="attrs"
            v-on="on"
          >
            Create Defi Account
          </v-btn>
        </template>
        <template>
          <v-stepper v-model="e6" vertical>
            <v-stepper-step :complete="e6 > 1" step="1">
              <table>
                <tr>
                  <td>
                    Create User Contract
                    <v-chip
                      class="ma-2"
                      color="green"
                      text-color="white"
                      v-if="managerdeployed"
                    >
                      Success
                    </v-chip>
                  </td>
                  <td>
                    <v-progress-circular
                      indeterminate
                      v-if="isuserloading"
                      class="ml-5"
                      color="primary"
                    >
                    </v-progress-circular>
                  </td>
                </tr>
              </table>
            </v-stepper-step>

            <v-stepper-content step="1">
              <v-card color="white" flat class="mb-12"
                >Create the Base user Account that stores your contracts'
                adresses. Basically a UserManager</v-card
              >
              <v-btn class="success" v-on:click="createAccount" text>
                Deploy Contracts
              </v-btn>
            </v-stepper-content>

            <v-stepper-step :complete="e6 > 2" step="2">
              <table>
                <tr>
                  <td>
                    Create Your Token Manager Contract
                   <v-chip
                     class="ma-2"
                     color="green"
                     text-color="white"
                     v-if="tokendeployed"
                   >
                     Success
                   </v-chip>
                  </td>
                  <td>
                    <v-progress-circular
                      indeterminate
                      v-if="istokenloading"
                      class="ml-5"
                      color="primary"
                    >
                    </v-progress-circular>
                  </td>
                </tr>
              </table>
            </v-stepper-step>

            <v-stepper-content step="2">
              <v-card color="white" flat class="mb-12"
                >Create the Token manager that stores your tokens' adresses,
                name, color, and more. . .
              </v-card>
            </v-stepper-content>

            <v-stepper-step :complete="e6 > 3" step="3">
              <table>
                <tr>
                  <td>
                    Create Your Budget Manager Contract
                    <v-chip
                      class="ma-2"
                      color="green"
                      text-color="white"
                      v-if="budgetdeployed"
                    >
                      Success
                    </v-chip>
                  </td>
                  <td>
                    <v-progress-circular
                      indeterminate
                      v-if="isbudgetloading"
                      class="ml-5"
                      color="primary"
                    >
                    </v-progress-circular>
                  </td>
                </tr>
              </table>
            </v-stepper-step>

            <v-stepper-content step="3">
              <v-card color="white" flat class="mb-12"
                >Create the Budget manager that stores your Tx's that contain
                categories and decriptions.</v-card
              >
            </v-stepper-content>
            <v-stepper-step :complete="e6 > 3" step="4">
              <table>
                <tr>
                  <td>
                    Create Your Wallet Manager Contract 
                    <v-chip
                      class="ma-2"
                      color="green"
                      text-color="white"
                      v-if="walletdeployed"
                    >
                      Success
                    </v-chip>
                  </td>
                  <td>
                    <v-progress-circular
                      indeterminate
                      v-if="iswalletloading"
                      class="ml-5"
                      color="primary"
                    >
                    </v-progress-circular>
                  </td>
                </tr>
              </table>
            </v-stepper-step>

            <v-stepper-content step="4">
              <v-card color="white" flat class="mb-12"
                >Create the Wallet Manager that keeps a record of which wallets
                you own, and makes sure you own them.</v-card
              >
            </v-stepper-content>

            <v-stepper-step step="5">
              Sign In !
            </v-stepper-step>
            <v-stepper-content step="5">
              <v-card color="white" flat class="mb-12"
                >Congratulations, your contracts are now ready ! you may now
                sign-in</v-card
              >
              <table>
                <tr>
                  <td><OneWalletLogin /></td>
                  <td>
                    <v-btn class="float-right" text>
                      Cancel
                    </v-btn>
                  </td>
                </tr>
              </table>
            </v-stepper-content>
          </v-stepper>
        </template>
      </v-dialog>
    </div>
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import Wallet from "../javascript/wallet.js";
import store from "../store";
import hmy from "../javascript/hmy";
import userFactoryContract from "../../build/contracts/UserFactory.json";
import userManagerContract from "../../build/contracts/UserManager.json";
import OneWalletLogin from "./OneWalletLogin.vue";
const { fromBech32 } = require("@harmony-js/crypto");
const Web3 = require("web3");
/*
   export BASEuserWallet=0x5a85D9f251c568c322b8bd4169A85EDd3eFE870E;

   export BASEuserBudget=0x7B5235f774b69Ba27806257f00Ef30d178FCe2c2;

   export BASEuserToken=0xc277f1FFf7A04B1e31b0aAa9c59c3bAD115BB07f;

   export USERMANAGER=0xb1c605295D92b34Ea80331B38AB37176DA55D978;

   export USERFACTORY=0x75c43101e943FBA8c6aBb211466D463bbC4BeB88;
*/

//var fs = require("fs");
export default {
  name: "createAccount",
  props: {
    msg: String
  },
  components: {
    OneWalletLogin
    // LedgerWalletLogin,
  },
  data() {
    return {
      e6: 1,
      isuserloading: false,
      istokenloading: false,
      isbudgetloading: false,
      iswalletloading: false,
      walletdeployed: false,
      managerdeployed: false,
      budgetdeployed: false,
      tokendeployed: false,
      dialog: ""
    };
  },
  methods: {
    createAccount: async function() {
      const wallet = new Wallet();
      await wallet.signin();
      //return wallet;

      //store.commit("hasSignedIn", true);
      store.commit("setUserAddress", wallet.address);
      //alert("Welcome Back : " + store.state.address + "!");
      await this.createManager();
      // `event` is the native DOM event
    },
    createManager: async function() {
      this.isuserloading = true;
      const wallet = new Wallet();

      await wallet.signin();

      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 75000
      };
      const web3 = new Web3();
      const zeroxAddr = fromBech32(store.state.address);
      var params = web3.eth.abi.encodeFunctionCall(
        {
          name: "initialize",
          type: "function",
          inputs: [
            {
              type: "string",
              name: "_name"
            },
            {
              type: "address",
              name: "_data"
            }
          ]
        },
        ["Hello Worlds", zeroxAddr]
      );
      const data = params;
      console.log(data);
      const unattachedContract = await this.initializeContract(
        userFactoryContract,
        store.state.OPENFI
      );
      const contract = wallet.attachToContract(unattachedContract);
      const gas = await contract.methods.createUser(data).estimateGas(options1);
      console.log(gas);
      const value = await contract.methods.createUser(data).send(options);

      const manageraddr = await contract.methods
        .getUserContractAddress(zeroxAddr)
        .call();

      console.log("value address : " + value);
      store.commit("setUserManagerAddr", manageraddr);

      this.createTokenContract();
    },
    createTokenContract: async function() {
      this.isuserloading = false;
      this.istokenloading = true;
      this.managerdeployed = true;
      this.e6 += 1;
      const wallet = new Wallet();
      await wallet.signin();
      const zeroxAddr = fromBech32(store.state.address);
      const web3 = new Web3();

      const unattachedUserFactoryContract = await this.initializeContract(
        userFactoryContract,
        store.state.OPENFI
      );
      const userFactoryContract1 = wallet.attachToContract(
        unattachedUserFactoryContract
      );
      const manageraddr = await userFactoryContract1.methods
        .getUserContractAddress(zeroxAddr)
        .call();

      var data = web3.eth.abi.encodeFunctionCall(
        {
          name: "initialize",
          type: "function",
          inputs: [
            {
              type: "address",
              name: "_data"
            }
          ]
        },
        [zeroxAddr]
      );
      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 25000
      };
      console.log("UserManager address Token: " + manageraddr);
      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        manageraddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);
      const gas = await contract.methods
        .createTokenContract(data)
        .estimateGas(options1);
      console.log("create contracts gas : " + gas);

      const value = await contract.methods
        .createTokenContract(data)
        .send(options);
      console.log(value);
      this.createBudgetContract();
    },
    createWalletContract: async function() {
      this.isbudgetloading = false;
      this.iswalletloading = true;
      this.budgetdeployed = true;
      this.e6 += 1;
      const wallet = new Wallet();
      await wallet.signin();
      const zeroxAddr = fromBech32(store.state.address);
      const web3 = new Web3();

      const unattachedUserFactoryContract = await this.initializeContract(
        userFactoryContract,
        store.state.OPENFI
      );
      const userFactoryContract1 = wallet.attachToContract(
        unattachedUserFactoryContract
      );
      const manageraddr = await userFactoryContract1.methods
        .getUserContractAddress(zeroxAddr)
        .call();

      var data = web3.eth.abi.encodeFunctionCall(
        {
          name: "initialize",
          type: "function",
          inputs: [
            {
              type: "address",
              name: "_data"
            }
          ]
        },
        [zeroxAddr]
      );
      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 25000
      };
      console.log("UserManager address Token: " + manageraddr);
      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        manageraddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);
      const gas = await contract.methods
        .createWalletContract(data)
        .estimateGas(options1);
      console.log(gas);

      const value = await contract.methods
        .createWalletContract(data)
        .send(options);
      console.log(value);
      this.e6 += 1;
      this.iswalletloading = false;
      this.walletdeployed = true;
    },
    createBudgetContract: async function() {
      this.istokenloading = false;
      this.isbudgetloading = true;
      this.tokendeployed = true;
      this.e6 += 1;
      const wallet = new Wallet();
      await wallet.signin();
      const zeroxAddr = fromBech32(store.state.address);
      const web3 = new Web3();
      const unattachedUserFactoryContract = await this.initializeContract(
        userFactoryContract,
        store.state.OPENFI
      );
      const userFactoryContract1 = wallet.attachToContract(
        unattachedUserFactoryContract
      );
      const manageraddr = await userFactoryContract1.methods
        .getUserContractAddress(zeroxAddr)
        .call();

      var data = web3.eth.abi.encodeFunctionCall(
        {
          name: "initialize",
          type: "function",
          inputs: [
            {
              type: "address",
              name: "_data"
            }
          ]
        },
        [zeroxAddr]
      );
      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 25000
      };
      console.log("UserManager address Token: " + manageraddr);
      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        manageraddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);
      const gas = await contract.methods
        .createBudgetContract(data)
        .estimateGas(options1);
      console.log(gas);

      const value = await contract.methods
        .createBudgetContract(data)
        .send(options);
      console.log(value);
      this.createWalletContract();
    },
    initializeContract: async function(contract, address) {
      const abi = contract.abi;
      const contractAddress = address;
      const contractInstance = hmy.contracts.createContract(
        abi,
        contractAddress
      );
      return contractInstance;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
