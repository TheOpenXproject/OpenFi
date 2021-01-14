<template>
  <div class="getTxCategories">
    <b-button variant="warning" v-on:click="createAccount" id="loginButton"
      >Get Categories</b-button
    >
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import Wallet from "../javascript/wallet.js";
import store from "../store";
import hmy from "../javascript/hmy";
import contract from "../../../../build/contracts/User.json";
//var fs = require("fs");
export default {
  name: "getTxCategories",
  props: {
    msg: String
  },
  methods: {
    createAccount: async function() {
      const wallet = new Wallet();
      await wallet.signin();
      //return wallet;

      store.commit("hasSignedIn", true);
      store.commit("setUserAddress", wallet.address);
      alert(
        "Welcome Back : " + store.state.address + store.state.userContract + "!"
      );
      await this.createUser();
      // `event` is the native DOM event
    },
    createUser: async function() {
      const wallet = new Wallet();
      await wallet.signin();

      let options = {
        gasPrice: 1000000000,
        gasLimit: 210000
      };
      const unattachedContract = await this.initializeContract();
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .setTxCategory("qd", "dd")
        .send(options);
      console.log("hello :", value);
    },
    initializeContract: async function() {
      const abi = contract.abi;
      const contractAddress = store.state.userContract;
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
