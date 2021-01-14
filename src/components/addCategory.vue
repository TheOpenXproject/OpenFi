<template>
  <div class="addCategory">
    <input v-model="txid" placeholder="Tx ID" />
    <input v-model="category" placeholder="Category" />

    <b-button variant="success" v-on:click="addCategory" id="lol"
      >Add Category to Tx</b-button
    >

    <b-button variant="success" v-on:click="getTxCategory" id="lold"
      >get</b-button
    >
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import store from "../store";
import hmy from "../javascript/hmy";
import contract from "../../build/contracts/UserManager.json";
//var fs = require("fs");
export default {
  name: "login",
  props: {
    msg: String
  },
  methods: {
    addCategory: async function() {
      const wallet = store.state.wallet;
      let str = [this.txid, this.category];
      console.log(str);
      let options = {
        gasPrice: 1000000000,
        gasLimit: 2100000
      };
      const unattachedContract = await this.initializeContract();
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods.setTxCategory(str).send(options);
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
    },
    getTxCategory: async function() {
      const wallet = store.state.wallet;

      let options = {
        gasPrice: 1000000000,
        gasLimit: 210000
      };
      const unattachedContract = await this.initializeContract();
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .getTxCategory(
          "0xe42368e1886b851b0a2a83a658602588a7cf17b05bb7d684e5ae85b110143297"
        )
        .call(options);
      console.log("hello :", value);
      return value;
    }
  },
  data() {
    return {
      txid: "",
      category: ""
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
