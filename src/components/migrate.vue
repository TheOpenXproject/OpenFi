<template>
  <div class="migrate">
    <template>

          <v-dialog
          transition="dialog-bottom-transition"
          max-width="1000"
          heigh="auto"
          >
          <template v-slot:activator="{ on, attrs }">
            <v-btn dark  class="orange darken-2
            center " v-bind="attrs"
            v-on="on" center>
            <table>
              <tr>
                <td>Migrate with </td>
                <td>	<v-img
                  class="ml-8"
                  lazy-src="../assets/metamask.png"
                  max-height="25"
                  max-width="25"
                  src="../assets/metamask.png"
                  ></v-img></td>
                  <br>

                </tr></table>
              </v-btn>
            </template>
            <template v-slot:default="dialog" class="p-0 pt-0">
              <v-card height="100%" width="">
                <v-toolbar
                height="40px"
                color="orange lighten-0"
                dark
                small
                ><v-img
                contain
                lazy-src="../assets/metamask.png"
                max-height="25"
                max-width="25"
                src="../assets/metamask.png"
                ></v-img><span class="pl-5">Ethereum to Harmony bridge</span></v-toolbar>
   
                  <template >
                    <v-stepper v-model="e1">
                      <v-container class="pa-0 pb-0 ma-0">
                        <v-row class="pa-0 pt-0">
                          <v-col cols="12" md="4" lg="4">
                            <v-card height="100%" small class="px-0 pt-0 pb-0" color="orange lighten-3">
                            
                              <v-stepper-step
                              :complete="e1 > 1"
                              corlor="orange"
                              step="1"
                              >
                              Intro:
                            </v-stepper-step>
                            
                            <v-stepper-step
                            :complete="e1 > 2"
                            step="2"
                            >
                            Disclaimer
                          </v-stepper-step>

                            <v-stepper-step
                            :complete="e1 > 3"
                            step="3"
                            >
                            Getting Started
                          </v-stepper-step>

                          <v-stepper-step
                            :complete="e1 > 4"
                            step="4"
                            >
                            Connect Metamask
                          </v-stepper-step>

                          <v-stepper-step
                            :complete="e1 > 5"
                            step="5"
                            >
                            Connect One Wallet
                          </v-stepper-step>

                          <v-stepper-step
                            :complete="e1 > 6"
                            step="6"
                            >
                            Migrate
                          </v-stepper-step>

                            <v-stepper-step
                            :complete="e1 > 7"
                            step="7"
                            >
                            Swap
                          </v-stepper-step>
                          
                          <v-stepper-step step="8">
                            What Now ?
                          </v-stepper-step>
                        
                        </v-card>
                      </v-col>
                      <v-col cols="12" md="8" lg="8" >
                        <v-stepper-items>
                          <v-stepper-content step="1" class="mb-0">
                            <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                            >
                            <h2>Intro</h2> <br>
                            Hi, and welcome to the Migration Center.<br><br> This is useful if you have tokens on the Ethereum Blockchain and want to bring them over to Harmony in order to benefit from their amazingly fast, efficient, and low cost blockchain.<br>
                            <br>
                            So, lets get you started. Here You will be asked to Transfer tokens from Ethereum to Harmony.<br> <br>Note that this is <b>fully reversible.</b><br>

                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
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
                            <h2>Disclaimer</h2> <br>
                            First of all <b> This Project is currently in Developement and isnt meant to be used just yet.</b><br><br>
                            This Bridge was Built, and is actively maintained by Harmony. <br>
                            <br>
                            Second thing i want to Cover is that you shouldnt place money on the contract you encounter here.<br> All you will be paying are the gas fees required for transactions. <br><br>

                            Speaking of Tx gas Fees, migrating your tokens to harmony should cost no more that 5 dollars, you will then have access to all that Harmony has to provide.
                            <ul>
                              <li>low tx cost</li>
                              <li>high speed</li>
                              <li>sharding</li>
                              <li> smart contracts</li>
                              ...
                            </ul>

                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
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
                            <v-divider></v-divider><br>
                            <b>You are going to need 2 things:</b>
                            <ol>
                              <li>Metamask Web Wallet</li>
                              <li>Harmony One Wallet</li>
                            </ol>
                            <br>
                            If you dont have the <b>Harmony One Web Wallet</b>, please install it from the <b>Chrome</b> browser <b>App Store</b>. Its free. <br><br>
                            We assume here that you already own Ether and have some available it your metamask wallet.<br><br> If you dont Go buy some and come back.(that is until we bring in fiat transfers.)<br>
                            <br>
                            If you have <b>Both Wallets Installed</b>, you may <b>continue</b>.
                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
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
                            <v-divider></v-divider><br>
                            <center><b>Please Connect your Wallets</b></center><br><br><br><br><br>
                            <center>
                            <v-container>
                            <v-btn large class="orange" @click="initMetamask()">
                               <v-img
                              contain
                              lazy-src="../assets/metamask.png"
                              max-height="25"
                              max-width="25"
                              src="../assets/metamask.png"
                              ></v-img>
                         Connect Metamask
                          </v-btn>
                          <v-row>
                            <v-col>
                                   <v-btn large width="100%" class="blue elevation-5 ma-0" @click="initOneWallet()">
                                      <v-img
                                     contain
                                     lazy-src="../assets/logo.png"
                                     max-height="25"
                                     max-width="25"
                                     src="../assets/logo.png"
                                     ></v-img>
                                Connect One Wallet
                                 </v-btn>
                            </v-col>
                            <v-col width="100%">
                             <v-sheet
                             large
                             class="text-left float-left pt-3"
                               color="white"
                               elevation="1"
                              height="100%"
                               width="100%"
                             >One Address : </v-sheet>
                            </v-col>
                          </v-row>


                        </v-container>
                        </center>
                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
                          cancel
                        </v-btn>
                      </v-stepper-content>
                          <v-stepper-content step="5" class="mb-0">
                            <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                            >
                            <h2>Metamask</h2>
                            <v-divider></v-divider><br>
                            <center><b>Please Connect To your One wallet</b></center><br><br><br><br><br>
                            <center>
                            <v-container>
                            <v-btn fab large class="blue" @click="initOneWallet()">
                            <v-img
                            contain
                            lazy-src="../assets/logo.png"
                            max-height="40"
                            max-width="40"
                            src="../assets/logo.png"
                            ></v-img>
                          </v-btn>
                        </v-container>
                        </center>
                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
                          cancel
                        </v-btn>
                      </v-stepper-content>
                       <v-stepper-content step="6" class="mb-0">
                            <v-card
                            flat
                            class=""
                            color="white lighten-1"
                            height="500"
                            >
                            <h2>Migrate</h2>
                            <v-divider></v-divider><br>
                            <center><b>Migrate</b></center><br><br><br><br><br>
                            <center>
                            <v-container>
                            <v-btn fab large class="red" @click="migrate_token">
                            <v-img
                            contain
                            lazy-src="../assets/logo.png"
                            max-height="40"
                            max-width="40"
                            src="../assets/logo.png"
                            ></v-img>
                          </v-btn>
                        </v-container>
                        </center>
                          </v-card>
                          <div class="small" disabled> *okay</div>

                          <v-btn
                          class="float-right"
                          color="success"
                          @click="e1++"
                          >
                          Continue
                        </v-btn>
                        <v-btn class="float-right" @click="dialog.value=false" text>
                          cancel
                        </v-btn>
                      </v-stepper-content>
                    <v-stepper-content step="8">
                      <v-card
                      class="mb-12"
                      color="green lighten-1"
                      height="auto"
                      dark
                      ><center>
                        Now you're all set to start deploying your smart contracts to use OpenFi. <br>
                        click on continue to continue (lol)
                      </center>
                    </v-card>
                    <v-btn @click="e1--" text>
                      Back
                    </v-btn>
                    <v-btn
                    class="float-right"
                    color="success"
                    @click="dialog.value=false"
                    >
                    Done
                  </v-btn>
                </v-stepper-content>
              </v-stepper-items>
            </v-col >

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
const { BridgeSDK, TOKEN, EXCHANGE_MODE, STATUS } = require('bridge-sdk');
const configs = require('bridge-sdk/lib/configs');
const bridgeSDK = new BridgeSDK({ logLevel: 0 });
const Web3 = require('web3');
import OneWallet from "../javascript/OneWallet.js";
import store from "../store"

export default {
  name: "migrate",
  props: {
    msg: String
  },
  components: {
},
  data() {
    return {
      e1: 1,
      ethTokens:{
        WETH: "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
        WBTC: "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599",
        BUSD: "0x4fabb145d64652a948d72533023f6e7a623c7c53",
        LINK: "0x514910771af9ca656af840dff83e8264ecf986ca",
        AAVE: "0x7fc66500c84a76ad7e9c93437bfc5ac33e2ddae9",
        YFI: "0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e",

      }
    };
  },
  methods: {
    initMetamask: async function(){
      console.log(TOKEN.ETH)
      await bridgeSDK.init(configs.testnet);
      bridgeSDK.setUseMetamask(true);
       const web3 = new Web3(window.ethereum);
      const ethEnabled = () => {
        if (window.ethereum) {

          window.ethereum.enable();
          return true;
        }
        return false;
      }
      if (!ethEnabled()) {
        alert("Please install an Ethereum-compatible browser or extension like MetaMask to use this dApp!");
      }

      const accounts = await web3.eth.getAccounts()
      
      store.commit("setMetamaskAddress", accounts[0]);
      console.log(store.state.metamaskaddress)


    },
    initOneWallet: async function(){
      const wallet = new OneWallet();
      await wallet.signin();
      store.commit("setUserAddress", wallet.address);
      console.log(wallet.address)
    },
    migrate_token: async function(){
      const bridgeSDK = new BridgeSDK({ logLevel: 2 }); // 2 - full logs, 1 - only success & errors, 0 - logs off

          await bridgeSDK.init(configs.testnet);


          let operationId;

          // display operation status
          let intervalId = setInterval(async () => {
              if (operationId) {
                  const operation = await bridgeSDK.api.getOperation(operationId);

                  
                  console.log(operation.status);
                  console.log(
                    'Action: ',
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
                      erc20Address: "0xdAC17F958D2ee523a2206206994597C13D831ec7",
                      amount: 0.01,
                      oneAddress: store.state.address,
                      ethAddress: store.state.metamaskaddress,
                  },
                  id => (operationId = id)
              );
          } catch (e) {
              console.log('Error: ', e.message);
          }

          process.exit();
    }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.bridge{
	overflow: hidden;
}
/style>
