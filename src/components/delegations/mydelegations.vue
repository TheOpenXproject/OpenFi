<template>
  <div class="allvalidators rounded-lg">
    <v-container>
      <div v-if="!isLoaded">
        <v-progress-linear indeterminate></v-progress-linear>
      </div>
      <div v-if="isLoaded">
        <v-row cols="6" md="6" sm="6">
          <v-col>
            <v-card
              width="100%"
              height="auto"
              class="m-2"
              v-for="items in delegationdata"
              v-bind:key="items.key"
            >
              <v-card-title class="small green truncate lighten-1">
                <v-spacer></v-spacer
                ><b>
                  <div v-if="validatordata[items.key].name">
                    {{ validatordata[items.key].name }}
                  </div> </b
                ><v-spacer></v-spacer>
              </v-card-title>
              <v-card-text>
                <v-row>
                  <v-col cols="4" md="4" sm="4">
                    <v-container>
                      <v-col cols="12" md="12" sm="12"
                        ><img
                          width="100%"
                          class="d-flex align-center"
                          :src="
                            'https://api.stake.hmny.io/networks/mainnet/validators/' +
                              items.address +
                              '/avatar'
                          "
                          onerror="javascript:this.src='https://www.pikpng.com/pngl/b/263-2631740_empty-avatar-png-user-png-clipart.png'"
                      /></v-col>
                    </v-container>
                  </v-col>
                  <v-col cols="8" md="8" sm="8">
                    <v-container>
                      <v-col cols="12" md="12" sm="12">{{
                        validatordata[items.key].status
                      }}</v-col
                      ><v-divider></v-divider>
                      <v-col cols="12" md="12" sm="12">{{
                        validatordata[items.key].address
                      }}</v-col
                      ><v-divider></v-divider>
                      <v-col cols="12" md="12" sm="12">{{
                        validatordata[items.key].eposstatus
                      }}</v-col
                      ><v-divider></v-divider>
                      <v-col cols="12" md="12" sm="12">Total Delegations : {{
                        validatordata[items.key].totaldelegations
                      }}</v-col
                      ><v-divider></v-divider>

                      <v-col cols="12" md="12" sm="12">Amount : {{
                        delegationdata[items.key].amount
                      }}</v-col
                      ><v-divider></v-divider>
                      <v-col cols="12" md="12" sm="12">Rewards : {{
                        delegationdata[items.key].rewards
                      }}</v-col
                      ><v-divider></v-divider>
                      <v-col cols="12" md="12" sm="12">{{
                        delegationdata[items.key].delegator
                      }}</v-col
                      ><v-divider></v-divider> </v-container
                  ></v-col>
                  
                </v-row>
              </v-card-text>
              <v-spacer></v-spacer>
              <v-card-actions>
                <v-spacer></v-spacer>

                <v-container class="d-flex align-center">
                  <v-row justify="center">
                    <v-dialog v-model="dialogx" max-width="600px">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn color="white"  v-bind="attrs" v-on="on">
                        unDelegate
                      </v-btn>
                    </template>
                    <v-card>
                      <v-card-title>
                        <span class="headline">unDelegate</span>
                      </v-card-title>
                      <v-card-text>
                        <v-container>
                          <v-row>
                            <v-col cols="12" sm="12" md="12">
                              unDelegate from : {{ items.name }}
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
                          >*use harmony for now</small
                        >
                      </v-card-text>
                      <v-card-actions>
                        <v-spacer></v-spacer>

                        <v-btn
                          color="blue darken-1"
                          text
                          @click="undelegate(validatordata[items.key].address, amount)"
                        >
                          Send
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog></v-row>
                </v-container>
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </div>
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
const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");

export default {
  name: "mydelegations",
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
    getalldelegations: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getDelegationsByDelegator",
        params: ["one1dqm6nv6vfa8ks7mnprnchzsk6zggk9zcs44al7"]
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

          for (var i = 0; i < results.result.length; i++) {
            const numstr = numToStr(results.result[i].amount)
            const Wei = new BN(numstr);
            const expected = fromWei(Wei, Units.szabo);
            const numstr1 = numToStr(results.result[i].reward)
            const Wei1 = new BN(numstr1);
            const expected1 = fromWei(Wei1, Units.szabo);

            this.delegationdata.push({
              key: i,
              //name : results.
              amount: expected,
              address: results.result[i].validator_address,
              rewards: expected1,
              delegator: results.result[i].delegator_address
            });
          }
        })
        .catch(error => console.log("error", error));
    },
      undelegate: async function(address, amount) {
      hmy.stakings.setTxParams({
        gasLimit: 25000,
        gasPrice: numberToHex(new hmy.utils.Unit("1").asGwei().toWei()),
        chainId: 1
      });

      const delegate = hmy.stakings.undelegate({
        delegatorAddress: store.state.address,
        validatorAddress: address,
        amount: numberToHex(new Unit(amount).asOne().toWei())
      });
      const delegateStakingTx = delegate.build();
      console.log(store.state.wallet.signStakingTxn(delegateStakingTx));
    },
    getValidatorInfo: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");
      var parsedobj = JSON.parse(JSON.stringify(this.delegationdata))
      console.log("parsed obj : "+ parsedobj)

      console.log(this.delegationdata);
      var i = 0;

      while (i < this.delegationdata.length) {

        var raw = JSON.stringify({
          jsonrpc: "2.0",
          id: 1,
          method: "hmyv2_getValidatorInformation",
          params: [this.delegationdata[i].address]
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
            console.log(results)
            const numstr = numToStr(results.result.["total-delegation"])
            const Wei = new BN(numstr);
            const expected = fromWei(Wei, Units.szabo);
            this.validatordata.push({
              status: results.result.["active-status"],
              eposstatus: results.result["epos-status"],
              apr: results.result.lifetime.apr,
              totaldelegations: expected,
              name: results.result.validator.name,
               address: results.result.validator.address,
            });
          })
          .catch(error => console.log("error", error));
        i++;
      }
    }
  },

  data() {
    return {
      blocknumber: null,
      isLoaded: false,
      delegationdata: [],
      validatordata: [],
      dialogx: null
    };
  },
  mounted: async function() {
    await this.getblocknumber();
    await this.getalldelegations();
    await this.getValidatorInfo();

    this.isLoaded = true;
  }
};
</script>

<style scoped>
.truncate {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
