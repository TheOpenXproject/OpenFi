<template>
  <div class="allvalidators rounded-lg">
    <v-container>
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab @click="getElectedvalidators()">Elected</v-tab>
        <v-tab @click="getNotElectedvalidators()">Not Elected</v-tab>
        <v-tab @click="getInactivevalidators()">Inactive</v-tab>
        <v-tab @click="getallvalidators()">All</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-container>
                <div v-if="!isLoaded">
                  <v-progress-linear indeterminate></v-progress-linear>
                </div>
                <div v-if="isLoaded">
                  <v-row cols="12" md="6">
                    <v-card
                      width="31%"
                      height="auto"
                      class="m-2 d-flex flex-column"
                      v-for="items in validatordata"
                      v-bind:key="items.key"
                    >
                      <v-card-title class="small green truncate lighten-1">
                        <v-spacer></v-spacer><b> {{ items.name }} </b
                        ><v-spacer></v-spacer>
                      </v-card-title>
                      <v-card-text>
                        <br />
                        <img
                          width="100px"
                          :src="
                            'https://api.stake.hmny.io/networks/mainnet/validators/' +
                              items.address +
                              '/avatar'
                          "
                          onerror="javascript:this.src='https://www.pikpng.com/pngl/b/263-2631740_empty-avatar-png-user-png-clipart.png'"
                        />
                        <br />

                        <br />

                        <small>{{ items.address }} </small>

                        <br />

                        {{ items.status }}
                        <br />
                        <v-divider></v-divider>
                        <small>{{ items.details }} </small>
                        <v-divider></v-divider>
                        <br />

                        Fee : {{ items.rate }} %
                      </v-card-text>
                      <v-spacer></v-spacer>

                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-container class="d-flex align-center">
                          <v-row justify="center">
                            <v-dialog v-model="dialogx" max-width="600px">
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn
                                  color="primary"
                                  dark
                                  v-bind="attrs"
                                  v-on="on"
                                >
                                  Delegate
                                </v-btn>
                              </template>
                              <v-card>
                                <v-card-title>
                                  <span class="headline">Delegate</span>
                                </v-card-title>
                                <v-card-text>
                                  <v-container>
                                    <v-row>
                                      <v-col cols="12" sm="12" md="12">
                                        Delegate to : {{ items.name }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12">
                                        Address : {{ items.address }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12"
                                        >Amount :
                                        <v-text-field
                                          v-model="amount"
                                          width="60%"
                                          required
                                        ></v-text-field>
                                      </v-col>
                                    </v-row>
                                  </v-container>
                                  <small
                                    >*at this time you cant undelegate here (use
                                    harmony)</small
                                  >
                                </v-card-text>
                                <v-card-actions>
                                  <v-spacer></v-spacer>

                                  <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="delegate(items.address, amount)"
                                  >
                                    Send
                                  </v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-dialog>
                          </v-row>
                        </v-container>
                        <v-spacer></v-spacer>
                      </v-card-actions>
                    </v-card>
                  </v-row>
                </div>
              </v-container>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-container>
                <div v-if="!isLoaded">
                  <v-progress-linear indeterminate></v-progress-linear>
                </div>
                <div v-if="isLoaded">
                  <v-row cols="12" md="6">
                    <v-card
                      width="31%"
                      height="auto"
                      class="m-2 d-flex flex-column"
                      v-for="items in validatordata"
                      v-bind:key="items.key"
                    >
                      <v-card-title class="small green truncate lighten-1">
                        <v-spacer></v-spacer><b> {{ items.name }} </b
                        ><v-spacer></v-spacer>
                      </v-card-title>
                      <v-card-text>
                        <br />
                        <img
                          width="100px"
                          :src="
                            'https://api.stake.hmny.io/networks/mainnet/validators/' +
                              items.address +
                              '/avatar'
                          "
                          onerror="javascript:this.src='https://www.pikpng.com/pngl/b/263-2631740_empty-avatar-png-user-png-clipart.png'"
                        />
                        <br />

                        <br />

                        <small>{{ items.address }} </small>

                        <br />

                        {{ items.status }}
                        <br />
                        <v-divider></v-divider>
                        <small>{{ items.details }} </small>
                        <v-divider></v-divider>
                        <br />

                        Fee : {{ items.rate }} %
                      </v-card-text>
                      <v-spacer></v-spacer>

                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-container class="d-flex align-center">
                          <v-row justify="center">
                            <v-dialog v-model="dialogx" max-width="600px">
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn
                                  color="primary"
                                  dark
                                  v-bind="attrs"
                                  v-on="on"
                                >
                                  Delegate
                                </v-btn>
                              </template>
                              <v-card>
                                <v-card-title>
                                  <span class="headline">Delegate</span>
                                </v-card-title>
                                <v-card-text>
                                  <v-container>
                                    <v-row>
                                      <v-col cols="12" sm="12" md="12">
                                        Delegate to : {{ items.name }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12">
                                        Address : {{ items.address }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12"
                                        >Amount :
                                        <v-text-field
                                          v-model="amount"
                                          width="60%"
                                          required
                                        ></v-text-field>
                                      </v-col>
                                    </v-row>
                                  </v-container>
                                  <small
                                    >*at this time you cant undelegate here (use
                                    harmony)</small
                                  >
                                </v-card-text>
                                <v-card-actions>
                                  <v-spacer></v-spacer>

                                  <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="delegate(items.address, amount)"
                                  >
                                    Send
                                  </v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-dialog>
                          </v-row>
                        </v-container>
                        <v-spacer></v-spacer>
                      </v-card-actions>
                    </v-card>
                  </v-row>
                </div>
              </v-container>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-container>
                <div v-if="!isLoaded">
                  <v-progress-linear indeterminate></v-progress-linear>
                </div>
                <div v-if="isLoaded">
                  <v-row cols="12" md="6">
                    <v-card
                      width="31%"
                      height="auto"
                      class="m-2 d-flex flex-column"
                      v-for="items in validatordata"
                      v-bind:key="items.key"
                    >
                      <v-card-title class="small green truncate lighten-1">
                        <v-spacer></v-spacer><b> {{ items.name }} </b
                        ><v-spacer></v-spacer>
                      </v-card-title>
                      <v-card-text>
                        <br />
                        <img
                          width="100px"
                          :src="
                            'https://api.stake.hmny.io/networks/mainnet/validators/' +
                              items.address +
                              '/avatar'
                          "
                          onerror="javascript:this.src='https://www.pikpng.com/pngl/b/263-2631740_empty-avatar-png-user-png-clipart.png'"
                        />
                        <br />

                        <br />

                        <small>{{ items.address }} </small>

                        <br />

                        {{ items.status }}
                        <br />
                        <v-divider></v-divider>
                        <small>{{ items.details }} </small>
                        <v-divider></v-divider>
                        <br />

                        Fee : {{ items.rate }} %
                      </v-card-text>
                      <v-spacer></v-spacer>

                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-container class="d-flex align-center">
                          <v-row justify="center">
                            <v-dialog v-model="dialogx" max-width="600px">
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn
                                  color="primary"
                                  dark
                                  v-bind="attrs"
                                  v-on="on"
                                >
                                  Delegate
                                </v-btn>
                              </template>
                              <v-card>
                                <v-card-title>
                                  <span class="headline">Delegate</span>
                                </v-card-title>
                                <v-card-text>
                                  <v-container>
                                    <v-row>
                                      <v-col cols="12" sm="12" md="12">
                                        Delegate to : {{ items.name }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12">
                                        Address : {{ items.address }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12"
                                        >Amount :
                                        <v-text-field
                                          v-model="amount"
                                          width="60%"
                                          required
                                        ></v-text-field>
                                      </v-col>
                                    </v-row>
                                  </v-container>
                                  <small
                                    >*at this time you cant undelegate here (use
                                    harmony)</small
                                  >
                                </v-card-text>
                                <v-card-actions>
                                  <v-spacer></v-spacer>

                                  <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="delegate(items.address, amount)"
                                  >
                                    Send
                                  </v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-dialog>
                          </v-row>
                        </v-container>
                        <v-spacer></v-spacer>
                      </v-card-actions>
                    </v-card>
                  </v-row>
                </div>
              </v-container>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-container>
                <div v-if="!isLoaded">
                  <v-progress-linear indeterminate></v-progress-linear>
                </div>
                <div v-if="isLoaded">
                  <v-row cols="12" md="6">
                    <v-card
                      width="31%"
                      height="auto"
                      class="m-2 d-flex flex-column"
                      v-for="items in validatordata"
                      v-bind:key="items.key"
                    >
                      <v-card-title class="small green truncate lighten-1">
                        <v-spacer></v-spacer><b> {{ items.name }} </b
                        ><v-spacer></v-spacer>
                      </v-card-title>
                      <v-card-text>
                        <br />
                        <img
                          width="100px"
                          :src="
                            'https://api.stake.hmny.io/networks/mainnet/validators/' +
                              items.address +
                              '/avatar'
                          "
                          onerror="javascript:this.src='https://www.pikpng.com/pngl/b/263-2631740_empty-avatar-png-user-png-clipart.png'"
                        />
                        <br />

                        <br />

                        <small>{{ items.address }} </small>

                        <br />

                        {{ items.status }}
                        <br />
                        <v-divider></v-divider>
                        <small>{{ items.details }} </small>
                        <v-divider></v-divider>
                        <br />

                        Fee : {{ items.rate }} %
                      </v-card-text>
                      <v-spacer></v-spacer>

                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-container class="d-flex align-center">
                          <v-row justify="center">
                            <v-dialog v-model="dialogx" max-width="600px">
                              <template v-slot:activator="{ on, attrs }">
                                <v-btn
                                  color="primary"
                                  dark
                                  v-bind="attrs"
                                  v-on="on"
                                >
                                  Delegate
                                </v-btn>
                              </template>
                              <v-card>
                                <v-card-title>
                                  <span class="headline">Delegate</span>
                                </v-card-title>
                                <v-card-text>
                                  <v-container>
                                    <v-row>
                                      <v-col cols="12" sm="12" md="12">
                                        Delegate to : {{ items.name }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12">
                                        Address : {{ items.address }}
                                      </v-col>
                                      <v-col cols="12" sm="12" md="12"
                                        >Amount :
                                        <v-text-field
                                          v-model="amount"
                                          width="60%"
                                          required
                                        ></v-text-field>
                                      </v-col>
                                    </v-row>
                                  </v-container>
                                  <small
                                    >*at this time you cant undelegate here (use
                                    harmony)</small
                                  >
                                </v-card-text>
                                <v-card-actions>
                                  <v-spacer></v-spacer>

                                  <v-btn
                                    color="blue darken-1"
                                    text
                                    @click="delegate(items.address, amount)"
                                  >
                                    Send
                                  </v-btn>
                                </v-card-actions>
                              </v-card>
                            </v-dialog>
                          </v-row>
                        </v-container>
                        <v-spacer></v-spacer>
                      </v-card-actions>
                    </v-card>
                  </v-row>
                </div>
              </v-container>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </div>
</template>

<script>
import store from "../../store";

import hmy from "../../javascript/hmy";
const {
  numberToHex,

  Unit
} = require("@harmony-js/utils");
//const { Units, numToStr, fromWei } = require("@harmony-js/utils");
//const { BN } = require("@harmony-js/crypto");

export default {
  name: "allvalidatiors",
  props: {
    msg: String
  },
  components: {},
  methods: {
    getblocknumber: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_blockNumber",
        params: []
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(results => {
          results = JSON.parse(results);
          this.blocknumber = results.result;
        })
        .catch(error => console.log("error", error));
    },
    getallvalidators: async function() {
      this.isLoaded = false;
      this.validatordata = [];

      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getAllValidatorInformationByBlockNumber",
        params: [-1, this.blocknumber - 1]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          const results = JSON.parse(result);
          console.log(results);
          var i = 0;

          while (i < results.result.length) {
            //if (results.result[i]["active-status"] != "inactive") {
            this.validatordata.push({
              name: results.result[i].validator.name,
              status: results.result[i]["active-status"],
              pos_status: results.result[i]["epos-status"],
              details: results.result[i].validator.details,
              rate: parseFloat(results.result[i].validator.rate) * 100,
              address: results.result[i].validator.address
            });
            //}

            i++;
          }
        })
        .catch(error => console.log("error", error));
      this.isLoaded = true;
    },
    getNotElectedvalidators: async function() {
      this.isLoaded = false;
      this.validatordata = [];

      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getAllValidatorInformationByBlockNumber",
        params: [-1, this.blocknumber - 1]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          const results = JSON.parse(result);
          console.log(results);
          var i = 0;

          while (i < results.result.length) {
            if (
              results.result[i]["active-status"] != "inactive" &&
              results.result[i]["booted-status"] == "lost epos auction"
            ) {
              this.validatordata.push({
                name: results.result[i].validator.name,
                status: results.result[i]["active-status"],
                pos_status: results.result[i]["epos-status"],
                details: results.result[i].validator.details,
                rate: parseFloat(results.result[i].validator.rate) * 100,
                address: results.result[i].validator.address
              });
            }

            i++;
          }
        })
        .catch(error => console.log("error", error));
      this.isLoaded = true;
    },
    getInactivevalidators: async function() {
      this.isLoaded = false;
      this.validatordata = [];

      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getAllValidatorInformationByBlockNumber",
        params: [-1, this.blocknumber - 1]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          const results = JSON.parse(result);
          console.log(results);
          var i = 0;

          while (i < results.result.length) {
            if (results.result[i]["active-status"] == "inactive") {
              this.validatordata.push({
                name: results.result[i].validator.name,
                status: results.result[i]["active-status"],
                pos_status: results.result[i]["epos-status"],
                details: results.result[i].validator.details,
                rate: parseFloat(results.result[i].validator.rate) * 100,
                address: results.result[i].validator.address
              });
            }

            i++;
          }
        })
        .catch(error => console.log("error", error));
      this.isLoaded = true;
    },
    getElectedvalidators: async function() {
      this.validatordata = [];

      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getAllValidatorInformationByBlockNumber",
        params: [-1, this.blocknumber - 1]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          const results = JSON.parse(result);
          console.log(results);
          var i = 0;

          while (i < results.result.length) {
            if (results.result[i]["epos-status"] == "currently elected") {
              this.validatordata.push({
                name: results.result[i].validator.name,
                status: results.result[i]["active-status"],
                pos_status: results.result[i]["epos-status"],
                details: results.result[i].validator.details,
                rate: parseFloat(results.result[i].validator.rate) * 100,
                address: results.result[i].validator.address
              });
            }

            i++;
          }
        })
        .catch(error => console.log("error", error));
      this.isLoaded = true;
    },

    delegate: async function(address, amount) {
      hmy.stakings.setTxParams({
        gasLimit: 25000,
        gasPrice: numberToHex(new hmy.utils.Unit("1").asGwei().toWei()),
        chainId: 1
      });

      const delegate = hmy.stakings.delegate({
        delegatorAddress: store.state.address,
        validatorAddress: address,
        amount: numberToHex(new Unit(amount).asOne().toWei())
      });
      const delegateStakingTx = delegate.build();
      console.log(store.state.wallet.signStakingTxn(delegateStakingTx));
    }
  },

  data() {
    return {
      blocknumber: null,
      isLoaded: false,
      validatordata: [],
      tabselected: "Elected",
      All: null
    };
  },
  mounted: async function() {
    await this.getblocknumber();

    this.getElectedvalidators();
  }
};
</script>

<style scoped>
.card-actions {
  vertical-align: bottom;
  bottom: 0;
}
.truncate {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
