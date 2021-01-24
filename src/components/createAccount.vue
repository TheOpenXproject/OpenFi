<template>
  <div class="createAccount">
    <template>
      <v-row justify="space-around">
        <v-col cols="auto">
          <v-dialog transition="dialog-bottom-transition" max-width="1000">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="green darken-1"
                class="px-6"
                dark
                v-bind="attrs"
                v-on="on"
              >
                Deploy Contracts
              </v-btn>
            </template>

            <template v-slot:default="dialog">
              <v-card height="100%" width="">
                <v-toolbar height="40px" color="green lighten-1" dark small
                  ><span class="pl-5"
                    >Getting Started on OpenFi..</span
                  ></v-toolbar
                >
                <v-card-text class="mt-5">
                  <template>
                    <v-stepper v-model="e1">
                      <v-stepper-header>
                        <v-stepper-step :complete="e1 > 1" step="1">
                          Intro
                        </v-stepper-step>

                        <v-divider></v-divider>

                        <v-stepper-step :complete="e1 > 2" step="2">
                          Disclaimer
                        </v-stepper-step>

                        <v-divider></v-divider>

                        <v-stepper-step step="3" :complete="e1 > 3">
                          Choose Wallet
                        </v-stepper-step>
                        <v-divider></v-divider>

                        <v-stepper-step step="4" :complete="e1 > 4">
                          Manager Deploy
                        </v-stepper-step>
                        <v-divider></v-divider>

                        <v-stepper-step step="5" :complete="e1 > 5">
                          Wallet Deploy
                        </v-stepper-step>

                        <v-divider></v-divider>

                        <v-stepper-step step="6" :complete="e1 > 6">
                          Budget Deploy
                        </v-stepper-step>

                        <v-divider></v-divider>
                        <v-stepper-step step="7" :complete="e1 > 7">
                          Token Deploy
                        </v-stepper-step>
                      </v-stepper-header>

                      <v-stepper-items>
                        <v-stepper-content step="1">
                          <v-card
                            flat
                            class="mb-2"
                            color="white lighten-1"
                            height="auto"
                          >
                            <v-container>
                              <h2>Intro</h2>
                              <br />
                              Hi, you will be guided in deploying your own
                              contracts that will help you manage your Wallets,
                              Tokens, Transactions on Harmony. Please make sure
                              you have a funded wallet. This site Currently
                              supports the Ledger nano S and harmony One Wallet.
                              <br />
                              You will need to publish a total of 4 contracts in
                              order to use this Service. <br /><br />
                              <b>#1 The Manager Contract:</b> This Contract
                              helps you manage your 3 other contracts you are
                              going to deploy.<br /><br />
                              <b>#2 The Wallet Contract:</b> This will help you
                              manage your multiple wallets that you will come to
                              have on Harmony.<br /><br />
                              <b>#3 The Budget Contract:</b> This one will help
                              you manage where your tokens are going and will
                              serve as a support for your banking
                              applications<br />
                              <b>#4 The Token Contract:</b> as you may have
                              guessed, This will help you manage tokens you
                              Create, Buy, Sell<br /><br /><br /><br />
                            </v-container>
                          </v-card>
                          <v-btn @click="dialog.value = false" text>
                            cancel
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content id="bridge" step="2">
                          <v-card flat class="" color="white" height="auto">
                            <h2>Disclaimer :</h2>
                            <br />
                            <div class="red">Currently In Developement!</div>
                            <br />

                            <br />
                            <h3>
                              Since this is developement please take note the
                              following :
                            </h3>
                            <br />
                            Contracts will be upgraded on a regular basis. That
                            means you will loose your saved data (for now) And
                            wont get back the Gas you spent.<br />
                            Use common Sense :<br /><br />
                            <br />If you save data on the blockchain, keep in
                            mind that it is accessible to anyone who has enough
                            will power, though the architecture of this app
                            greatens the difficulty <b>Do not</b> send tokens to
                            your contracts (for now) <br /><br />
                            <b
                              >Always check what you are signing. (this site
                              doesnt ask for funds. you only pay gas fees. dont
                              sign if VALUE > 0)</b
                            ><br /><br />
                          </v-card>

                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="3">
                          <v-card
                            class="mb-12"
                            color="green lighten-1"
                            min-height="400"
                            dark
                            ><v-container class="text-center" fluid>
                              <h5>
                                Choose which Wallet to use. if you dont have any
                                of the wallets mentionned below, please get one
                                or Migrate from Ethereum
                              </h5>

                              <br /><br />
                              <center>
                                <v-row class="">
                                  <v-col>
                                    <v-checkbox
                                      v-model="selected"
                                      label="Harmony One Wallet"
                                      value="OneWallet"
                                    ></v-checkbox>
                                  </v-col>
                                  <v-col>
                                    <v-checkbox
                                      v-model="selected"
                                      label="Ledger Nano S"
                                      value="LedgerWallet"
                                      disabled
                                    ></v-checkbox>
                                  </v-col>
                                  <v-col>
                                    <v-checkbox
                                      v-model="selected"
                                      label="Math Wallet"
                                      value="MathWallet"
                                      disabled
                                    ></v-checkbox>
                                  </v-col>
                                </v-row>
                              </center>
                            </v-container>
                          </v-card>
                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="InitWallet()"
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="4">
                          <v-card
                            class="mb-12 text-center"
                            color="green lighten-1"
                            min-height="400"
                            dark
                          >
                            <h2>
                              Deploy The Manager.
                              <v-container>
                                <v-progress-circular
                                  indeterminate
                                  v-if="isuserloading != false"
                                  class="ml-5"
                                  color="white"
                                >
                                </v-progress-circular>
                              </v-container>
                            </h2>
                            <br /><br /><br />
                            <div v-if="TX != null">
                              <center>
                                <div v-if="manageraddr != null">
                                  Your Manager Contract : {{ manageraddr }}
                                </div>
                                <br />
                                <v-card
                                  light
                                  class="grey lighten-2 elevation-5 justify-center rounded-lg"
                                  width="300px"
                                >
                                  <v-container class="">
                                    <v-row>
                                      <v-col> status :</v-col>
                                      <v-col>{{
                                        TX.transaction.txStatus
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Confirmations :</v-col>
                                      <v-col>{{
                                        TX.transaction.confirmations
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Checks :</v-col>
                                      <v-col>
                                        {{
                                          TX.transaction.confirmationCheck
                                        }}</v-col
                                      >
                                    </v-row>
                                    <v-row>
                                      <v-col>Hash : </v-col>
                                      <v-col> {{ TX.transaction.id }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col> ErrSig :</v-col>
                                      <v-col> {{ TX.errorFuncSig }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Nonce :</v-col>
                                      <v-col>{{ TX.transaction.nonce }} </v-col>
                                    </v-row>
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                  </v-container>
                                </v-card>
                              </center>
                              <br />
                            </div>
                            <v-btn
                              class="green lighten 3 elevation-5
                            "
                              @click="createManager()"
                              text
                            >
                              Deploy
                            </v-btn>
                          </v-card>
                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="
                              e1++;
                              TX = null;
                            "
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="5">
                          <v-card
                            class="mb-12 text-center"
                            color="green lighten-1"
                            min-height="400"
                            dark
                          >
                            <h2>
                              Deploy Wallet Contract.
                              <v-container fluid>
                                <v-progress-circular
                                  indeterminate
                                  v-if="iswalletloading != false"
                                  class="ml-5"
                                  color="white"
                                >
                                </v-progress-circular>
                              </v-container>
                            </h2>
                            <br /><br /><br />
                            <div v-if="TX != null">
                              <center>
                                <div v-if="walletaddr != null">
                                  Your Wallet Contract : {{ walletaddr }}
                                </div>
                                <br />
                                <v-card
                                  light
                                  class="grey lighten-2 elevation-5 justify-center rounded-lg"
                                  width="300px"
                                >
                                  <v-container class="">
                                    <v-row>
                                      <v-col> status :</v-col>
                                      <v-col>{{
                                        TX.transaction.txStatus
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Confirmations :</v-col>
                                      <v-col>{{
                                        TX.transaction.confirmations
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Checks :</v-col>
                                      <v-col>
                                        {{
                                          TX.transaction.confirmationCheck
                                        }}</v-col
                                      >
                                    </v-row>
                                    <v-row>
                                      <v-col>Hash : </v-col>
                                      <v-col> {{ TX.transaction.id }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col> ErrSig :</v-col>
                                      <v-col> {{ TX.errorFuncSig }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Nonce :</v-col>
                                      <v-col>{{ TX.transaction.nonce }} </v-col>
                                    </v-row>
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                  </v-container>
                                </v-card>
                              </center>
                            </div>
                            <center>
                              <v-btn @click="createWalletContract" text>
                                Deploy
                              </v-btn>
                            </center>
                          </v-card>
                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="
                              e1++;
                              TX = null;
                            "
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content step="6">
                          <v-card
                            class="mb-12 text-center"
                            color="green lighten-1"
                            min-height="400"
                            dark
                          >
                            <h2>
                              Deploy Budget Contract.
                              <v-container fluid>
                                <v-progress-circular
                                  indeterminate
                                  v-if="isbudgetloading != false"
                                  class="ml-5"
                                  color="white"
                                >
                                </v-progress-circular>
                              </v-container>
                            </h2>
                            <br /><br /><br />
                            <div v-if="TX != null">
                              <center>
                                <div v-if="budgetaddr != null">
                                  Your Budget Contract : {{ budgetaddr }}
                                </div>
                                <br />
                                <v-card
                                  light
                                  class="grey lighten-2 elevation-5 justify-center rounded-lg"
                                  width="300px"
                                >
                                  <v-container class="">
                                    <v-row>
                                      <v-col> status :</v-col>
                                      <v-col>{{
                                        TX.transaction.txStatus
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Confirmations :</v-col>
                                      <v-col>{{
                                        TX.transaction.confirmations
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Checks :</v-col>
                                      <v-col>
                                        {{
                                          TX.transaction.confirmationCheck
                                        }}</v-col
                                      >
                                    </v-row>
                                    <v-row>
                                      <v-col>Hash : </v-col>
                                      <v-col> {{ TX.transaction.id }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col> ErrSig :</v-col>
                                      <v-col> {{ TX.errorFuncSig }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Nonce :</v-col>
                                      <v-col>{{ TX.transaction.nonce }} </v-col>
                                    </v-row>
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                  </v-container>
                                </v-card>
                              </center>
                            </div>

                            <center>
                              <v-btn @click="createBudgetContract" text>
                                Deploy
                              </v-btn>
                            </center>
                          </v-card>
                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="
                              e1++;
                              TX = null;
                            "
                          >
                            Continue
                          </v-btn>
                        </v-stepper-content>
                        <v-stepper-content step="7">
                          <v-card
                            class="mb-12 text-center"
                            color="green lighten-1"
                            min-height="400"
                            dark
                          >
                            <h2>
                              Deploy Token Contract.
                              <v-container fluid>
                                <v-progress-circular
                                  indeterminate
                                  v-if="istokenloading"
                                  class="ml-5"
                                  color="white"
                                >
                                </v-progress-circular>
                              </v-container>
                            </h2>
                            <br /><br /><br />
                            <div v-if="TX != null">
                              <center>
                                <div v-if="tokenaddr != false">
                                  Your Token Contract : {{ tokenaddr }}
                                </div>
                                <br />
                                <v-card
                                  light
                                  class="grey lighten-2 elevation-5 justify-center rounded-lg"
                                  width="300px"
                                >
                                  <v-container class="">
                                    <v-row>
                                      <v-col> status :</v-col>
                                      <v-col>{{
                                        TX.transaction.txStatus
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Confirmations :</v-col>
                                      <v-col>{{
                                        TX.transaction.confirmations
                                      }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Checks :</v-col>
                                      <v-col>
                                        {{
                                          TX.transaction.confirmationCheck
                                        }}</v-col
                                      >
                                    </v-row>
                                    <v-row>
                                      <v-col>Hash : </v-col>
                                      <v-col> {{ TX.transaction.id }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col> ErrSig :</v-col>
                                      <v-col> {{ TX.errorFuncSig }}</v-col>
                                    </v-row>
                                    <v-row>
                                      <v-col>Nonce :</v-col>
                                      <v-col>{{ TX.transaction.nonce }} </v-col>
                                    </v-row>
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                  </v-container>
                                </v-card>
                              </center>
                              <div class="success">You may now sign in</div>
                            </div>
                            <center>
                              <v-btn @click="createTokenContract" text>
                                Deploy
                              </v-btn>
                            </center>
                          </v-card>
                          <v-btn @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="dialog.value = false"
                          >
                            Done
                          </v-btn>
                        </v-stepper-content>
                      </v-stepper-items>
                    </v-stepper>
                  </template>
                </v-card-text>
                <v-card-actions class="justify-end"> </v-card-actions>
              </v-card>
            </template>
          </v-dialog>
        </v-col>
      </v-row>
    </template>
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import store from "../store";
import hmy from "../javascript/hmy";
import userFactoryContract from "../../build/contracts/UserFactory.json";
import userManagerContract from "../../build/contracts/UserManager.json";
import OneWallet from "../javascript/OneWallet.js";
import LedgerWallet from "../javascript/LedgerWallet.js";
//import OneWalletLogin from "./OneWalletLogin.vue";
const { fromBech32 } = require("@harmony-js/crypto");

export default {
  name: "createAccount",
  props: {},
  components: {
    //OneWalletLogin
    // LedgerWalletLogin,
  },
  data() {
    return {
      e6: 1,
      e1: 1,
      TX: null,
      selected: null,
      isuserloading: false,
      istokenloading: false,
      isbudgetloading: false,
      iswalletloading: false,
      walletdeployed: false,
      managerdeployed: false,
      budgetdeployed: false,
      tokendeployed: false,
      manageraddr: null,
      tokenaddr: null,
      budgetaddr: null,
      walletaddr: null,
      dialog: ""
    };
  },
  methods: {
    InitWallet: async function() {
      if (this.selected == "LedgerWallet") {
        const wallet = new LedgerWallet();
        await wallet.signin();
        store.commit("setUserAddress", wallet.address);
        store.commit("setUserWallet", wallet);
      } else if (this.selected == "OneWallet") {
        const wallet = new OneWallet();
        await wallet.signin();

        store.commit("setUserAddress", wallet.address);
        store.commit("setUserWallet", wallet);
      }

      this.e1++;
    },
    createManager: async function() {
      this.isuserloading = true;
      const wallet = store.state.wallet;
      console.log(wallet.address);
      const options1 = { gasPrice: "0x3B9ACA00" };
      let options = {
        gasPrice: 1000000000,
        gasLimit: 2000000
      };
      // const web3 = new Web3();
      const zeroxAddr = fromBech32(store.state.address);
      console.log(zeroxAddr);
      const unattachedContract = await this.initializeContract(
        userFactoryContract,
        store.state.OPENFI
      );
      const contract = wallet.attachToContract(unattachedContract);
      const gas = await contract.methods.createUser().estimateGas(options1);
      console.log(gas);
      this.TX = await contract.methods.createUser().send(options);
      console.log("thistx = " + this.TX);
      const manageraddr = await contract.methods
        .getUserContractAddress(zeroxAddr)
        .call();

      this.manageraddr = manageraddr;
      store.commit("setUserManagerAddr", manageraddr);
      this.isuserloading = false;
    },
    createTokenContract: async function() {
      this.istokenloading = true;
      this.managerdeployed = true;
      const wallet = store.state.wallet;

      let options = {
        gasPrice: 1000000000,
        gasLimit: 1500000
      };
      console.log("UserManager address Token: " + store.state.userManagerAddr);
      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        store.state.userManagerAddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);

      this.TX = await contract.methods.createTokenContract().send(options);
      const TokenCaddr = await contract.methods
        .getUserTokenContractAddress()
        .call();
      //this.createBudgetContract();
      this.tokenaddr = TokenCaddr;
      this.isTokenloading = false;
    },
    createWalletContract: async function() {
      this.iswalletloading = true;

      const wallet = store.state.wallet;

      let options = {
        gasPrice: 1000000000,
        gasLimit: 700000
      };
      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        store.state.userManagerAddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);

      this.TX = await contract.methods.createWalletContract().send(options);
      const WalletCaddr = await contract.methods
        .getUserWalletContractAddress()
        .call();

      this.walletaddr = WalletCaddr;

      this.iswalletloading = false;
      this.walletdeployed = true;
    },
    createBudgetContract: async function() {
      this.isbudgetloading = true;
      this.tokendeployed = true;

      const wallet = store.state.wallet;

      let options = {
        gasPrice: 1000000000,
        gasLimit: 700000
      };

      const unattachedUserManagerContract = await this.initializeContract(
        userManagerContract,
        store.state.userManagerAddr
      );
      const contract = wallet.attachToContract(unattachedUserManagerContract);

      this.TX = await contract.methods.createBudgetContract().send(options);
      const BudgetCaddr = await contract.methods
        .getUserBudgetContractAddress()
        .call();

      this.Budgetaddr = BudgetCaddr;

      this.isbudgetloading = false;
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
