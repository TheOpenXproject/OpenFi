<template>
  <div class="createAccount">
    <div class="text-center">
      <v-card>
        <v-dialog v-model="dialog" width="500">
          <template v-slot:activator="{ on, attrs }">
            <v-btn color="red lighten-2" dark v-bind="attrs" v-on="on">
              Create Account Contracts
            </v-btn>
          </template>
          <template>
            <v-stepper v-model="e6" vertical>
              <v-stepper-step :complete="e6 > 1" step="1">
                Create User Contract
                <small>Create base Contract</small>
              </v-stepper-step>

              <v-stepper-content step="1">
                <v-card color="white" flat class="mb-12"
                  >Create the Base user Account that stores your contracts'
                  adresses. Basically a UserManager</v-card
                >
                <v-btn class="success" v-on:click="createAccount" text>
                  Deploy UserContract
                </v-btn>
              </v-stepper-content>

              <v-stepper-step :complete="e6 > 2" step="2">
                Create Your Token Manager Contract
              </v-stepper-step>

              <v-stepper-content step="2">
                <v-card color="white" flat class="mb-12"
                  >Create the Token manager that stores your tokens' adresses,
                  name, color, and more. . .
                </v-card>
                <v-btn class="success" v-on:click="createTokenManager">
                  Continue
                </v-btn>
              </v-stepper-content>

              <v-stepper-step :complete="e6 > 3" step="3">
                Create Your Budget Manager Contract
              </v-stepper-step>

              <v-stepper-content step="3">
                <v-card color="white" flat class="mb-12"
                  >Create the Budget manager that stores your Tx's that contain
                  categories and decriptions.</v-card
                >
                <v-btn class="success" v-on:click="createBudgetManager">
                  Continue
                </v-btn>
              </v-stepper-content>
              <v-stepper-step :complete="e6 > 3" step="4">
                Create Your Wallet Manager Contract
              </v-stepper-step>

              <v-stepper-content step="4">
                <v-card color="white" flat class="mb-12"
                  >Create the Wallet Manager that keeps a record of which
                  wallets you own, and makes sure you own them.</v-card
                >
                <v-btn class="success" v-on:click="createWalletManager">
                  Continue
                </v-btn>
              </v-stepper-content>

              <v-stepper-step step="5">
                Sign In !
              </v-stepper-step>
              <v-stepper-content step="5">
                <v-card color="white" flat class="mb-12"
                  >Congratulations, your contracts are now ready ! you may now
                  sign-in</v-card
                >
                <OneWalletLogin />
                <v-btn text>
                  Cancel
                </v-btn>
              </v-stepper-content>
            </v-stepper>
          </template>
        </v-dialog>
      </v-card>
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
export BASEuserWallet=0x2c8FE7aFB9e45bF0C764d3989Efd0f80914b2649;

export BASEuserBudget=0x5F216F007cA31a08bDd825554a4911cf5fa31009;

export BASEuserToken=0x194fc20f08B6A1323f0f60dB0D4865dfa822eC5D;

export USERMANAGER=0xB87EEBDf354cB896103F8b56c79024BCAaBE7c2E;

export USERFACTORY=0xC2D91AC1A9CD6827560F6f98Bc6B9682BD4070Ca;

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
      e6: 1
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
      await this.createUser();
      // `event` is the native DOM event
    },
    createUser: async function() {
      const wallet = new Wallet();

      await wallet.signin();

      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 135030
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
      const value = await contract.methods
        .createUser(data)
        .send(options)
        .then((this.e6 += 1));
      console.log("UserManager address : " + value);
      store.commit("setUserManagerAddr", value);
    },
    createTokenManager: async function() {
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
        gasLimit: 130690
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
      console.log(gas);

      const value = await contract.methods
        .createTokenContract(data)
        .send(options)
        .then((this.e6 += 1));
      console.log(value);
    },
    createWalletManager: async function() {
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
        gasLimit: 130690
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
        .send(options)
        .then((this.e6 += 1));
      console.log(value);
    },
    createBudgetManager: async function() {
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
        gasLimit: 130690
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
        .send(options)
        .then((this.e6 += 1));
      console.log(value);
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
