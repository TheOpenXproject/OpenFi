<template>
  <div class="Login">
    <v-container class="login">
      <v-row class="login">
        <v-col>
          <v-btn
            class="login"
            fab
            dark
            text
            large
            color="white"
            v-on:click="Login('LedgerWallet')"
          >
            <v-img
              src="../assets/ledger.png"
              alt=""
              contain
              height="60px"
              width="60px"
            >
            </v-img>
          </v-btn>
        </v-col>
        <v-col>
          <v-btn
            class="login"
            fab
            text
            large
            color="white"
            v-on:click="Login('OneWallet')"
          >
            <v-img
              src="../assets/one.png"
              alt=""
              contain
              height="60px"
              width="60px"
            >
            </v-img>
          </v-btn>
        </v-col>
      </v-row>
      <div v-if="loginError == true">
        <v-dialog v-model="loginError" width="500">
          <v-card>
            <v-card-title dark class="headline red lighten-2">
              Whoops...
            </v-card-title>
            <v-card-text>
              <br /><br /><br />
              <p>
                It apears you haven't deployed your contracts yet... You can try
                it out if you dont mind paying the gas fee. (~0.0049~ One)
              </p>
            </v-card-text>
            <v-divider></v-divider>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="loginError = false">
                I accept
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
    </v-container>
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import OneWallet from "../javascript/OneWallet.js";
import LedgerWallet from "../javascript/LedgerWallet.js";
import store from "../store";
import hmy from "../javascript/hmy";
import contractUserFactory from "../../build/contracts/UserFactory.json";
import contractUserManager from "../../build/contracts/UserManager.json";
const {tokens} = require("../javascript/BridgeTokenTruth.js");
//import UserTokenContract from "../../../../build/contracts/UserTokenContract.json";
//import UserWalletContract from "../../../../build/contracts/UserWalletContract.json";
//import UserBudgetContract from "../../../../build/contracts/UserBudgetContract.json";
const { fromBech32 } = require("@harmony-js/crypto");

//var fs = require("fs");
export default {
  name: "Login",
  props: {
    msg: String
  },
  data() {
    return {
      loginError: false
    };
  },
  methods: {
    Login: async function(wallet_type) {
      if (wallet_type == "LedgerWallet") {
        const wallet = new LedgerWallet();
        await wallet.signin();
        
        store.commit("setUserAddress", wallet.address);
        store.commit("setUserWallet", wallet);
        await this.getUserContracts(wallet);
      } else if (wallet_type == "OneWallet") {
        const wallet = new OneWallet();
        await wallet.signin();
        console.log(tokens.ETH)
        store.commit("setUserAddress", wallet.address);
        store.commit("setUserWallet", wallet);
        await this.getUserContracts(wallet);
      }

      //alert("Welcome Back : " + store.state.address + "!");

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
      console.log(UserManagerAddr);
      /* if (UserManagerAddr == "0x0000000000000000000000000000000000000000") {
        await window.onewallet.forgetIdentity();
        this.loginError = true;
        return 1;
      }*/

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
      store.commit("hasSignedIn", true);
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
<style scoped>
.login {
  margin-left: auto;
  margin-right: auto;
}
</style>
