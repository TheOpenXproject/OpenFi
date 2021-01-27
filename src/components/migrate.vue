<template>
  <div class="migrate">
    <template>
      <v-dialog
        transition="dialog-bottom-transition"
        max-width="1000"
        heigh="auto"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            dark
            class="orange darken-2
            center ml-2"
            v-bind="attrs"
            v-on="on"
            center
          >
            <table>
              <tr>
                <td>Migrate with</td>
                <td>
                  <v-img
                    class="ml-8"
                    lazy-src="../assets/metamask.png"
                    max-height="25"
                    max-width="25"
                    src="../assets/metamask.png"
                  ></v-img>
                </td>
                <br />
              </tr>
            </table>
          </v-btn>
        </template>
        <template v-slot:default="dialog" class="p-0 pt-0">
          <v-card height="100%" width="">
            <v-toolbar height="40px" color="orange lighten-0" dark small
              ><v-img
                contain
                lazy-src="../assets/metamask.png"
                max-height="25"
                max-width="25"
                src="../assets/metamask.png"
              ></v-img
              ><span class="pl-5">Ethereum to Harmony bridge</span></v-toolbar
            >

            <template>
              <v-stepper v-model="e1">
                <v-container class="pa-0 pb-0 ma-0">
                  <v-row class="pa-0 pt-0">
                    <v-col cols="12" md="4" lg="4">
                      <v-card
                        height="100%"
                        small
                        class="px-0 pt-0 pb-0"
                        color="orange lighten-3"
                      >
                        <v-stepper-step
                          :complete="e1 > 1"
                          corlor="orange"
                          step="1"
                        >
                          Intro:
                        </v-stepper-step>

                        <v-stepper-step :complete="e1 > 2" step="2">
                          Disclaimer
                        </v-stepper-step>

                        <v-stepper-step :complete="e1 > 3" step="3">
                          Getting Started
                        </v-stepper-step>

                        <v-stepper-step :complete="e1 > 4" step="4">
                          Connect Wallets
                        </v-stepper-step>

                        <v-stepper-step :complete="e1 > 5" step="5">
                          Migrate
                        </v-stepper-step>

                        <v-stepper-step :complete="e1 > 6" step="6">
                          Done
                        </v-stepper-step>
                      </v-card>
                    </v-col>
                    <v-col cols="12" md="8" lg="8">
                      <v-stepper-items color="">
                        <v-stepper-content step="1" class="mb-0">
                          <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                          >
                            <h2>Intro</h2>
                            <br />
                            Hi, and welcome to the Migration Center.<br /><br />
                            This is useful if you have tokens on the Ethereum
                            Blockchain and want to bring them over to Harmony in
                            order to benefit from their amazingly fast,
                            efficient, and low cost blockchain.<br />
                            <br />
                            So, lets get you started. Here You will be asked to
                            Transfer tokens from Ethereum to Harmony.<br />
                            <br />Note that this is <b>fully reversible.</b
                            ><br />
                          </v-card>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>

                          <v-btn
                            class="float-left"
                            @click="dialog.value = false"
                            text
                          >
                            cancel
                          </v-btn>
                        </v-stepper-content>
                        <v-stepper-content step="2" class="mb-0">
                          <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                          >
                            <h2>Disclaimer</h2>
                            <br />
                            First of all
                            <b>
                              This Project is currently in Developement and isnt
                              meant to be used just yet.</b
                            ><br /><br />
                            This Bridge was Built, and is actively maintained by
                            Harmony. <br />
                            <br />
                            Second thing i want to Cover is that you shouldnt
                            place money on the contract you encounter here.<br />
                            All you will be paying are the gas fees required for
                            transactions. <br /><br />

                            Speaking of Tx gas Fees, migrating your tokens to
                            harmony should cost no more that 5 dollars, you will
                            then have access to all that Harmony has to provide.
                            <ul>
                              <li>low tx cost</li>
                              <li>high speed</li>
                              <li>sharding</li>
                              <li>smart contracts</li>
                              ...
                            </ul>
                          </v-card>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                          <v-btn class="float-right" @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-left"
                            @click="dialog.value = false"
                            text
                          >
                            cancel
                          </v-btn>
                        </v-stepper-content>
                        <v-stepper-content step="3" class="mb-0">
                          <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                          >
                            <h2>Getting Started</h2>
                            <v-divider></v-divider><br />
                            <b>You are going to need 2 things:</b>
                            <ol>
                              <li>Metamask Web Wallet</li>
                              <li>Harmony One Wallet</li>
                            </ol>
                            <br />
                            If you dont have the <b>Harmony One Web Wallet</b>,
                            please install it from the <b>Chrome</b> browser
                            <b>App Store</b>. Its free. <br /><br />
                            We assume here that you already own Ether and have
                            some available it your metamask wallet.<br /><br />
                            If you dont Go buy some and come back.(that is until
                            we bring in fiat transfers.)<br />
                            <br />
                            If you have <b>Both Wallets Installed</b>, you may
                            <b>continue</b>.
                          </v-card>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                          <v-btn class="float-right" @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-left"
                            @click="dialog.value = false"
                            text
                          >
                            cancel
                          </v-btn>
                        </v-stepper-content>
                        <v-stepper-content step="4" class="mb-0">
                          <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                          >
                            <h2>Metamask</h2>
                            <v-divider></v-divider>
                            <center><b>Please Connect your Wallets</b></center>
                            <center>
                              <v-divider></v-divider>
                              <v-row>
                                <v-col>
                                  <v-btn
                                    large
                                    class="orange"
                                    width="100%"
                                    @click="initMetamask()"
                                  >
                                    <v-img
                                      contain
                                      lazy-src="../assets/metamask.png"
                                      max-height="25"
                                      max-width="25"
                                      src="../assets/metamask.png"
                                    ></v-img>
                                    Connect Metamask
                                    <div v-if="ethAddress != null">
                                      <v-chip
                                        class="float-left ml-5 pr-0"
                                        color="white"
                                        outlined
                                      >
                                        <v-icon left>
                                          mdi-check-all
                                        </v-icon>
                                      </v-chip>
                                    </div>
                                  </v-btn>
                                </v-col>
                              </v-row>
                              <v-row>
                                <v-col>
                                  <v-sheet
                                    large
                                    class="text-center float-left pt-3"
                                    color="orange lighten-3"
                                    elevation="1"
                                    height="50"
                                    width="100%"
                                    required
                                    >Ethereum Address :
                                    <b>{{ ethAddress }}</b></v-sheet
                                  >
                                </v-col> </v-row
                              ><br /><v-divider></v-divider><br />

                              <v-row>
                                <v-col>
                                  <v-btn
                                    large
                                    width="100%"
                                    class="blue elevation-5 ma-0"
                                    @click="initOneWallet()"
                                  >
                                    <v-img
                                      contain
                                      lazy-src="../assets/logo.png"
                                      max-height="25"
                                      max-width="25"
                                      src="../assets/logo.png"
                                    ></v-img>
                                    Connect One Wallet
                                    <div v-if="oneAddress != null">
                                      <v-chip
                                        class="float-left ml-5 pr-0"
                                        color="white"
                                        outlined
                                      >
                                        <v-icon left>
                                          mdi-check-all
                                        </v-icon>
                                      </v-chip>
                                    </div>
                                  </v-btn>
                                </v-col>
                              </v-row>
                              <v-row>
                                <v-col>
                                  <v-sheet
                                    large
                                    class="text-center mt-0 float-left pt-3 rounded-sm"
                                    color="blue lighten-3"
                                    elevation="1"
                                    height="50"
                                    width="100%"
                                    required
                                    >One Address : <b> {{ oneAddress }} </b>
                                  </v-sheet>
                                </v-col>
                              </v-row>

                              <v-divider></v-divider>
                            </center>
                          </v-card>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                          <v-btn class="float-right" @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-left"
                            @click="dialog.value = false"
                            text
                          >
                            cancel
                          </v-btn>
                        </v-stepper-content>

                        <v-stepper-content
                          step="5"
                          class="ma-0 white lighten-3"
                        >
                          <v-card
                            scrollable
                            flat
                            class=""
                            color="white lighten-3"
                            height="auto"
                          >
                            <h2>Migrate</h2>
                            <v-divider></v-divider>
                            <center>
                              <v-card
                                class="grey lighten-3 mt-6
                                     rounded-lg"
                                height="90"
                              >
                                <v-row>
                                  <v-col>
                                    <v-img
                                      contain
                                      fab
                                      lazy-src="../assets/WETH.png"
                                      max-height="50"
                                      max-width="50"
                                      src="../assets/WETH.png"
                                    ></v-img
                                    ><small>Wrapped Ether</small>
                                  </v-col>
                                  <v-col>
                                    <v-form ref="form">
                                      <v-text-field
                                        v-model="amount"
                                        label="Amount"
                                      ></v-text-field>
                                    </v-form>
                                  </v-col>
                                  <v-col>
                                    <v-btn
                                      @click="migrate_WETH()"
                                      color="green lighten-1 mt-3"
                                    >
                                      migrate
                                    </v-btn>
                                  </v-col>
                                </v-row>
                              </v-card>
                            </center>
                            <center>
                              <v-card
                                class="grey lighten-3 mt-6
                                 rounded-lg"
                                height="90"
                              >
                                <v-row>
                                  <v-col>
                                    <v-img
                                      contain
                                      fab
                                      lazy-src="../assets/WBTC.png"
                                      max-height="75"
                                      max-width="75"
                                      src="../assets/WBTC.png"
                                    ></v-img
                                    ><small>Wrapped Bitcoin</small>
                                  </v-col>
                                  <v-col>
                                    <v-form ref="form">
                                      <v-text-field
                                        v-model="amount"
                                        label="Amount"
                                      ></v-text-field>
                                    </v-form>
                                  </v-col>
                                  <v-col>
                                    <v-btn
                                      @click="migrate_WBTC()"
                                      color="green lighten-1 mt-3"
                                    >
                                      migrate
                                    </v-btn>
                                  </v-col>
                                </v-row>
                              </v-card>
                            </center>
                            <center>
                              <v-card
                                class="grey lighten-3 mt-6 rounded-lg"
                                height="90"
                              >
                                <v-row>
                                  <v-col>
                                    <v-img
                                      contain
                                      fab
                                      lazy-src="../assets/BUSD64.png"
                                      max-height="50"
                                      max-width="50"
                                      src="../assets/BUSD64.png"
                                    ></v-img
                                    ><small>Binance Usd</small>
                                  </v-col>
                                  <v-col>
                                    <v-form ref="form">
                                      <v-text-field
                                        v-model="amount"
                                        label="Amount"
                                      ></v-text-field>
                                    </v-form>
                                  </v-col>
                                  <v-col>
                                    <v-btn
                                      @click="migrate_BUSD()"
                                      color="green lighten-1 mt-3"
                                    >
                                      migrate
                                    </v-btn>
                                  </v-col>
                                </v-row>
                              </v-card>
                            </center>
                            <center>
                              <v-card
                                class="grey lighten-3 mt-6
                                 rounded-lg"
                                height="90"
                              >
                                <v-row>
                                  <v-col>
                                    <v-img
                                      contain
                                      fab
                                      lazy-src="../assets/USDT.png"
                                      max-height="50"
                                      max-width="50"
                                      src="../assets/USDT.png"
                                    ></v-img
                                    ><small>USD Tether</small>
                                  </v-col>
                                  <v-col>
                                    <v-form ref="form">
                                      <v-text-field
                                        v-model="amount"
                                        label="Amount"
                                      ></v-text-field>
                                    </v-form>
                                  </v-col>
                                  <v-col>
                                    <v-btn
                                      @click="migrate_USDT()"
                                      color="green lighten-2 mt-3"
                                    >
                                      migrate
                                    </v-btn>
                                  </v-col>
                                </v-row>
                              </v-card>
                            </center>
                            <center>
                              <v-card
                                class="grey lighten-3 mt-6
                                 rounded-lg mb-6"
                                height="90"
                              >
                                <v-row>
                                  <v-col>
                                    <v-img
                                      contain
                                      fab
                                      lazy-src="../assets/AAVE.png"
                                      max-height="50"
                                      max-width="50"
                                      src="../assets/AAVE.png"
                                    ></v-img
                                    ><small>Aave Finance</small>
                                  </v-col>
                                  <v-col>
                                    <v-form ref="form">
                                      <v-text-field
                                        v-model="amount"
                                        label="Amount"
                                      ></v-text-field>
                                    </v-form>
                                  </v-col>
                                  <v-col>
                                    <v-btn
                                      @click="migrate_AAVE()"
                                      color="green lighten-1 mt-3"
                                    >
                                      migrate
                                    </v-btn>
                                  </v-col>
                                </v-row>
                              </v-card>
                            </center>
                          </v-card>
                          <div
                            v-if="
                              migrationStatus == 'ongoing' ||
                                migrationError == true
                            "
                          >
                            <v-dialog v-model="dialogtx" width="400">
                              <v-card>
                                <v-card-title class="headline grey lighten-2">
                                  Status
                                </v-card-title>

                                <v-card-text>
                                  {{ migrationMessage }}
                                </v-card-text>

                                <v-divider></v-divider>

                                <v-card-actions>
                                  <v-spacer></v-spacer>
                                  <v-btn
                                    color="primary"
                                    text
                                    @click="dialogtx = false"
                                  >
                                    I accept
                                  </v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-dialog>
                          </div>

                          <v-btn
                            class="float-right"
                            color="success"
                            @click="e1++"
                          >
                            Continue
                          </v-btn>
                          <v-btn class="float-right" @click="e1--" text>
                            Back
                          </v-btn>

                          <v-btn
                            class="float-left"
                            @click="dialog.value = false"
                            text
                          >
                            cancel
                          </v-btn>
                        </v-stepper-content>
                        <v-stepper-content step="6">
                          <v-card height="400">
                            <h2>
                              <center>
                                Congrats you have Successfully migrated your
                                tokens To Harmony. Enjoy the Speed.
                              </center>
                            </h2>
                            <br /><br /><br /><br />
                            Next step is to Deploy your contracts !
                          </v-card>
                          <v-card>
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
                          </v-card>
                        </v-stepper-content>
                      </v-stepper-items>
                    </v-col>
                  </v-row>
                </v-container>
              </v-stepper>
            </template>
          </v-card>
        </template>
      </v-dialog>
    </template>
  </div>
</template>
<script>
const { BridgeSDK, TOKEN, EXCHANGE_MODE, STATUS } = require("bridge-sdk");
const configs = require("bridge-sdk/lib/configs");
const bridgeSDK = new BridgeSDK({ logLevel: 0 });
const Web3 = require("web3");
import OneWallet from "../javascript/OneWallet.js";
import store from "../store";

export default {
  name: "migrate",
  props: {
    msg: String
  },
  components: {},
  data() {
    return {
      e1: 1,
      dialogtx: true,
      oneAddress: null,
      ethAddress: null,
      migrationStatus: null,
      migrationError: null,
      migrationMessage: null,
      amount: 0,
      ethTokens: {
        WETH: "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
        WBTC: "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599",
        BUSD: "0x4fabb145d64652a948d72533023f6e7a623c7c53",
        AAVE: "0x7fc66500c84a76ad7e9c93437bfc5ac33e2ddae9",
        USDT: "0xdac17f958d2ee523a2206206994597c13d831ec7"
      }
    };
  },
  methods: {
    initMetamask: async function() {
      console.log(TOKEN.ETH);
      await bridgeSDK.init(configs.testnet);
      bridgeSDK.setUseMetamask(true);
      const web3 = new Web3(window.ethereum);
      const ethEnabled = () => {
        if (window.ethereum) {
          window.ethereum.enable();
          return true;
        }
        return false;
      };
      if (!ethEnabled()) {
        alert(
          "Please install an Ethereum-compatible browser or extension like MetaMask to use this dApp!"
        );
      }

      const accounts = await web3.eth.getAccounts();

      store.commit("setMetamaskAddress", accounts[0]);
      this.ethAddress = accounts[0];
      console.log(store.state.metamaskaddress);
    },
    initOneWallet: async function() {
      const wallet = new OneWallet();
      await wallet.signin();
      store.commit("setUserAddress", wallet.address);
      this.oneAddress = wallet.address;
      console.log(wallet.address);
    },
    migrate_WETH: async function() {
      await this.migrate_token(this.ethTokens.WETH, this.amount);
    },
    migrate_WBTC: async function() {
      await this.migrate_token(this.ethTokens.WBTC, this.amount);
    },
    migrate_BUSD: async function() {
      await this.migrate_token(this.ethTokens.BUSD, this.amount);
    },
    migrate_USDT: async function() {
      await this.migrate_token(this.ethTokens.USDT, this.amount);
    },
    migrate_AAVE: async function() {
      await this.migrate_token(this.ethTokens.AAVE, this.amount);
    },
    migrate_token: async function(tokenAddress, amount) {
      const bridgeSDK = new BridgeSDK({ logLevel: 2 }); // 2 - full logs, 1 - only success & errors, 0 - logs off

      await bridgeSDK.init(configs.mainnet);
      await bridgeSDK.setUseMetamask(true);
      let operationId;

      // display operation status
      let intervalId = setInterval(async () => {
        if (operationId) {
          const operation = await bridgeSDK.api.getOperation(operationId);
          this.migrationStatus = "ongoing";
          this.migrationMessage = operation.actions.filter(
            a => a.status === STATUS.IN_PROGRESS
          );
          console.log(
            "Action: ",
            operation.actions.filter(a => a.status === STATUS.IN_PROGRESS)
          );

          if (operation.status !== STATUS.IN_PROGRESS) {
            clearInterval(intervalId);
          }
        }
      }, 4000);

      try {
        await bridgeSDK.sendToken(
          {
            type: EXCHANGE_MODE.ETH_TO_ONE,
            token: TOKEN.ERC20,
            erc20Address: tokenAddress,
            amount: amount,
            oneAddress: this.oneAddress,
            ethAddress: this.ethAddress
          },
          id => (operationId = id)
        );
      } catch (e) {
        this.migrationError = true;
        this.migrationMessage = e.message;
        console.log("Error: ", e.message);
      }

      process.exit();
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.bridge {
  overflow: hidden;
}
</style>
