<template>
  <div class="OneWalletLogin">
    <v-btn
      class="mx-2"
      fab
      dark
      text
      large
      color="white"
      v-on:click="initOneWallet"
    >
      <v-img src="../assets/one.png" alt="" contain height="50px" width="50px">
      </v-img>
    </v-btn>
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import OneWallet from "../javascript/OneWallet.js";
import store from "../store";
import hmy from "../javascript/hmy";
import contractUserFactory from "../../build/contracts/UserFactory.json";
import contractUserManager from "../../build/contracts/UserManager.json";
//import UserTokenContract from "../../../../build/contracts/UserTokenContract.json";
//import UserWalletContract from "../../../../build/contracts/UserWalletContract.json";
//import UserBudgetContract from "../../../../build/contracts/UserBudgetContract.json";
const { fromBech32 } = require("@harmony-js/crypto");

//var fs = require("fs");
export default {
  name: "OneWalletLogin",
  props: {
    msg: String
  },
  methods: {
    initOneWallet: async function() {
      const wallet = new OneWallet();
      await wallet.signin();
      //return wallet;

      store.commit("hasSignedIn", true);
      console.log("signedinn");
      store.commit("setUserAddress", wallet.address);
      store.commit("setUserWallet", wallet);
      //alert("Welcome Back : " + store.state.address + "!");
      await this.getUserContracts(wallet);
      // `event` is the native DOM event
    },
    getUserContracts: async function(wallet) {
      const zeroxAddr = fromBech32(store.state.address);

      const unattachedContract = await this.initializeContract(
        contractUserFactory,
        store.state.OPENFI
      );
      const contract = wallet.attachToContract(unattachedContract);
      const UserManagerAddr = await contract.methods
        .getUserContractAddress(zeroxAddr)
        .call();
      console.log("UserManager address : " + UserManagerAddr);
      store.commit("setUserManagerAddr", UserManagerAddr);

      const unattachedManagerContract = await this.initializeContract(
        contractUserManager,
        UserManagerAddr
      );
      const UserManager = wallet.attachToContract(unattachedManagerContract);
      const UserWalletAddr = await UserManager.methods
        .getUserWalletContractAddress()
        .call();

      console.log("UserWalletAddr : " + UserWalletAddr);
      store.commit("setUserWalletAddr", UserWalletAddr);

      const UserTokenAddr = await UserManager.methods
        .getUserTokenContractAddress()
        .call();
      console.log("UserTokenAddr : " + UserTokenAddr);
      store.commit("setUserTokenAddr", UserTokenAddr);

      const UserBudgetAddr = await UserManager.methods
        .getUserBudgetContractAddress()
        .call();
      console.log("UserBudgetAddr : " + UserBudgetAddr);
      store.commit("setUserBudgetAddr", UserBudgetAddr);
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
