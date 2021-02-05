<template>
  <v-app id="TokenTruth">
    <div v-if="loggedIn">
      <v-app-bar app fixed class="white bars lighten-1">
        <v-toolbar-title>TokenTruth v0.1</v-toolbar-title>
        <div v-if="txid != null">
          TX id : {{ txid }} (for debugging check explorer)
        </div>

        <v-spacer />

        <v-btn color="error" v-on:click="logout">logout</v-btn>
      </v-app-bar>

      <v-main relative>
        <v-row justify="center">
          <v-dialog v-model="dialog" max-width="600px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="primary"
                dark
                v-bind="attrs"
                class="mb-5 mt-5"
                v-on="on"
              >
                Propose New Token
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Propose Token Listing</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field
                        label="Token Name*"
                        required
                        v-model="porpname"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field
                        label="Token Symbol*"
                        hint="example of helper text only on focus"
                        v-model="propsymbol"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field
                        label="Number of decimals*"
                        v-model="propdec"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                      <v-col cols="12">
                        <v-text-field
                          label="Token Address (hmy Ox00000)*"
                          required
                          v-model="propaddr"
                        ></v-text-field>
                      </v-col>
                      <v-text-field
                        label="Link To Token Image"
                        hint="250 by 250 with transparent bg"
                        v-model="propimg"
                        persistent-hint
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                      <v-text-field label="Website*" required></v-text-field>
                    </v-col>
                    <v-col cols="12">
                      <v-text-field
                        label="Description*"
                        required
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
                <small>*indicates required field</small>
              </v-card-text>
              <v-card-actions>
                <small>*TX Fee = 0.003 one</small>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="dialog = false">
                  Close
                </v-btn>
                <v-btn color="blue darken-1" text @click="SubmitToken()">
                  Submit
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-btn
            class="mb-5 mt-5"
            @click="
              getValidatedTokenList();
              Proposed = false;
            "
            >Get Verified Tokens</v-btn
          >

          <v-btn
            class="mb-5 mt-5"
            @click="
              getProposedTokenList();
              Proposed = true;
            "
            >Get Proposed Tokens</v-btn
          >
        </v-row>
        <!--  -->

        <div v-if="Proposed == true">
          <v-container>
            <v-row cols="12" md="12" lg="12" justify="center">
              <div v-for="items in propTokens" v-bind:key="items.key">
                <br />
                <v-card
                  height="400px"
                  width="600px"
                  class="mt-5 ml-1 rounded-t-lg "
                >
                  <v-card-title small class="white darken-2 elevation-1"
                    ><v-spacer /><v-btn>X</v-btn></v-card-title
                  >

                  <v-col cols="12" md="12" lg="12" class="pl-5 pr-5">
                    <v-row>Name :<v-spacer /> {{ items.name }}</v-row> <br />
                    <v-row>
                      Token Address : <v-spacer />{{ items.address }}</v-row
                    >
                    <br />
                    <v-row>
                      Symbol : <v-spacer />Symbol : {{ items.symbol }}
                    </v-row>
                    <br />
                    <v-row>
                      Decimals : <v-spacer /> Decimals : {{ items.decimals }}
                    </v-row>
                    <br />
                    <v-row> Img Source : <v-spacer />{{ items.image }}</v-row>
                    <br />
                  </v-col>
                  <br />
                  <v-col>
                    <v-row>
                      <v-spacer /> upvotes : {{ items.upvotes }}
                      <v-spacer /> downvotes : {{ items.downvotes }}
                      <v-spacer /> totalvotes : {{ items.totalvotes
                      }}<v-spacer /> <br />
                    </v-row>
                  </v-col>
                </v-card>
                <v-card class=" mt-2 ml-1 rounded-b-lg">
                  <v-row justify="center">
                    <v-btn
                      class="green lighten-1"
                      @click="vote(true, items.name)"
                      >Upvote</v-btn
                    ><br /><v-btn @click="vote(false, items.name)" class="red"
                      >DownVote</v-btn
                    >
                  </v-row>
                </v-card>
              </div>
            </v-row>
          </v-container>
        </div>

        <div v-if="Proposed == false">
          <v-card width="100%" class="pt-5 pl-2 pr-2 rounded-xl ">
            <v-row width="100%" justify="center">
              <div
                class="ml-2 mr-2"
                v-for="items in propTokens"
                v-bind:key="items.key"
              >
                <v-card width="100%" class="mt-5 ml-2 mr-2 pr-2 rounded-xl ">
                  <v-card-title
                    >{{ items.name[items.count] }} <v-spacer />
                    <img width="50px" :src="items.image[items.count]"
                  /></v-card-title>

                  <v-col cols="12" md="12" sm="12" class="pl-5 pr-5">
                    <v-row
                      >Name :<v-spacer /> {{ items.name[items.count] }}</v-row
                    ><br />
                    <v-row>
                      Token Address : <v-spacer />{{
                        items.address[items.count]
                      }}</v-row
                    ><br />
                    <v-row>
                      Symbol : <v-spacer />{{
                        items.symbol[items.count]
                      }}</v-row
                    >
                    <br />
                    <v-row>
                      Decimals : <v-spacer />{{
                        items.decimals[items.count]
                      }}</v-row
                    ><br />
                    <v-row>
                      Img : <v-spacer />{{ items.image[items.count] }}</v-row
                    >
                    <br />
                  </v-col>

                  <center></center>
                </v-card>
              </div>
            </v-row>
          </v-card>
        </div>
      </v-main>
    </div>
  </v-app>
</template>

<script>
//import Login from "./components/login.vue";
import store from "../store";
import TokenTruthContract from "../../build/contracts/TokenTruth.json";
import TokenProposalContract from "../../build/contracts/ProposeToken.json";
import OneWallet from "../javascript/OneWallet.js";
import hmy from "../javascript/hmy";
//import MoonDust from "../../../../build/contracts/MoonDust.json";
//const { fromBech32 } = require("@harmony-js/crypto");

export default {
  name: "App",

  components: {},
  props: {},
  methods: {
    logout: async function() {
      await window.onewallet.forgetIdentity();
      store.commit("hasSignedIn", false);
    },
    getProposedTokenList: async function() {
      // const zeroxAddr = fromBech32(store.state.address);
      this.propTokens = [];
      const wallet = new OneWallet();
      await wallet.signin();
      const unattachedContract = await this.initializeContract(
        TokenTruthContract,
        store.state.TokenTruthAddress
      );

      const contract = wallet.attachToContract(unattachedContract);
      const TokenProposals = await contract.methods.get_all_proposals().call();
      console.log(TokenProposals);

      var i = 0;

      while (i < TokenProposals.length) {
        const unattachedContracts = await this.initializeContract(
          TokenProposalContract,
          TokenProposals[i]
        );

        const contracts = wallet.attachToContract(unattachedContracts);
        const TokenProposalss = await contracts.methods
          .getTokenDetails()
          .call();
        console.log(TokenProposalss);

        const status = await contracts.methods.getStatus().call();
        console.log(status);
        this.propTokens.push({
          address: TokenProposalss[0],
          name: TokenProposalss[1],
          symbol: TokenProposalss[2],
          decimals: TokenProposalss[3],
          image: TokenProposalss[4],
          downvotes: status[1],
          upvotes: status[0],
          totalvotes: parseInt(status[0]) + parseInt(status[1])
        });

        i++;
      }
      console.log(i);

      this.isLoaded = true;
    },
    getValidatedTokenList: async function() {
      // const zeroxAddr = fromBech32(store.state.address);
      this.propTokens = [];
      const wallet = new OneWallet();
      await wallet.signin();
      const unattachedContract = await this.initializeContract(
        TokenTruthContract,
        store.state.TokenTruthAddress
      );

      const contract = wallet.attachToContract(unattachedContract);
      const TokenProposals = await contract.methods
        .get_all_verified_tokens()
        .call();

      var i = 0;
      console.log(TokenProposals);
      while (i <= TokenProposals[5] - 1) {
        this.propTokens.push({
          address: TokenProposals[0],
          name: TokenProposals[1],
          symbol: TokenProposals[2],
          decimals: TokenProposals[3],
          image: TokenProposals[4],
          count: i
        });

        i++;
      }

      this.isLoaded = true;
    },
    SubmitToken: async function() {
      const wallet = new OneWallet();
      await wallet.signin();
      const unattachedContract = await this.initializeContract(
        TokenTruthContract,
        store.state.TokenTruthAddress
      );
      let options = {
        gasPrice: 1000000000,
        gasLimit: 2000000
      };

      const contract = wallet.attachToContract(unattachedContract);
      const TokenProposals = await contract.methods
        .propose_token(
          this.propaddr,
          this.porpname,
          this.propsymbol,
          this.propdec,
          this.propimg
        )
        .send(options);
      console.log(TokenProposals);
      this.txid = contract.id;
    },
    vote: async function(_vote, _tokenName) {
      const wallet = new OneWallet();
      await wallet.signin();
      const unattachedContract = await this.initializeContract(
        TokenTruthContract,
        store.state.TokenTruthAddress
      );
      let options = {
        gasPrice: 1000000000,
        gasLimit: 200000
      };

      const contract = wallet.attachToContract(unattachedContract);
      const TokenProposals = await contract.methods
        .vote_token(_vote, _tokenName)
        .send(options);
      console.log(TokenProposals);
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
  },
  upvote: async function() {},

  data() {
    return {
      propTokens: [],
      Proposed: false,
      isloaded: false,
      dialog: false,
      propaddr: null,
      porpname: null,
      propsymbol: null,
      propdec: null,
      propimg: null,
      txid: null
    };
  },
  mounted: async function() {
    //await this.getProposedTokenList();
  },
  computed: {
    // a computed getter
    loggedIn: function() {
      // `this` points to the vm instance
      return store.state.signedIn;
    }
  }
};
</script>

<style type="text/css"></style>
