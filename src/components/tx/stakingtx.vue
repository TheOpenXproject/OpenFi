<template>
  <div class="stakingtx">
    <v-data-table
      
      :headers="headers"
      :items="eventTableData"
      item-key="name"
      class="table"
      reactive
    >
      <template v-slot:item="{ item }">
        <tr>
          <td class="truncate">{{ item.id }}</td>
          <td class="">{{ item.time }}</td>
          <td class="">{{ item.from }}</td>
          <td class="">{{ item.to }}</td>
          <td class="">{{ item.value }}</td>

          <td class="" v-if="item.category != null">
            {{ item.category }} 
          </td>
          <td class="" v-if="item.category == null">
            <template>
              <v-row justify="center">
                <v-dialog
                  v-model="dialogCat"
                  
                  max-width="600px"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-chip
                      color="primary"
                      dark
                      v-bind="attrs"
                      v-on="on"
                      small
                    >
                      +
                    </v-chip>
                  </template>
                  <v-card>
                    <v-card-title>
                      <span class="headline">New Category</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <v-col
                            cols="12"
                            sm="6"
                          >
                            <v-text-field
                              :items="item.id"
                              label="Tx*"
                              required

                            ></v-text-field>
                          </v-col>
                          <v-col
                            cols="12"
                            sm="6"
                          >
                            <v-autocomplete
                              :items="['Sent to friend', 'Car Payements', 'Rent', 'Food', 'Housing', 'Fees', 'Alimony(poor dads)', 'Saving', 'Insurance']"
                              label="Category"
                              multiple
                            ></v-autocomplete>
                          </v-col>
                        </v-row>
                      </v-container>
                      <small>All Fields Required *</small>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn
                        color="blue darken-1"
                        text
                        @click="dialogCat=false"
                      >
                        Close
                      </v-btn>
                      <v-btn
                        color="blue darken-1"
                        text
                        v-on:click="dialogCat.value=false"
                                         >
                        Save
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-row>
            </template>
          </td>
        </tr>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import store from "../../store";
import hmy from "../../javascript/hmy";
import contract from "../../../build/contracts/User.json";
const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");

export default {
  name: "stakingtx",
  props: {
    msg: String
  },

  methods: {
    getstakingtx: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmy_getStakingTransactionsHistory",
        params: [
          {
            address: "one1pgqzkwz95zd6cjjf7aa9lxjfppuy74kcgjn3pu",
            pageIndex: 0,
            pageSize: 1,
            fullTx: true,
            txType: "ALL",
            order: "ASC"
          }
        ]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);
          result = result.result.staking_transactions;
          console.log(result);
          if (result) {
            var n = 0;

            while (n < result.length) {
              let data = result[n];

              var a = new Date(data.timestamp * 1000);
              var year = a.getFullYear();
              var month = a.getMonth();
              var date = a.getDate();
              var hour = a.getHours();
              var min = a.getMinutes();
              var time =
                date + "/" + month + "/" + year + " " + hour + ":" + min;
              const value = parseInt(data.msg.amount);
              console.log(typeof value);

              // numberToString
              const str = numToStr(value);
              console.log(str);
              // fromWei
              const Wei = new BN(str);
              const expected = fromWei(Wei, Units.one);
              console.log(expected);

              this.eventTableData.push({
                id: data.hash,
                time: time,
                from: data.msg.delegatorAddress,
                to: data.msg.validatorAddress,
                value: expected
              });

              /*
              this.getTxCategory(data.hash).then(result => {
                const s = result
                this.eventTableData.push({
                  category: s
                })
              })
*/

              n++;
            }
          }
        })
        .catch(error => console.log("error", error));
    },
    getTxCategory: async function(txid) {
      const wallet = store.state.wallet;
      let options = {
        gasPrice: 1000000000,
        gasLimit: 210000
      };
      const unattachedContract = await this.initializeContract();
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods.getTxCategory(txid).call(options);
      return value;
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
    addCategory: async function(txid, category) {
      const wallet = store.state.wallet;
      var str;
      str[0] = txid;
      console.log(str[0]);
      str[1] = category;
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
    }
  },
  data() {
    return {
      eventTableData: [],
      Categorydialog: false,
      CategoryDialogData: null ,
      headers: [
        {
          text: "id",
          align: "start",
          sortable: false,
          value: "id",
          class: "blue rounded-tl-lg border-0"
        },

        { text: "date", value: "time", class: "blue border-0" },
        { text: "From", value: "from", class: "blue border-0" },
        { text: "To ", value: "to", class: "blue border-0" },
        { text: "Amount", value: "value", class: "blue border-0" },
        {
          text: "category ",
          value: "category",
          class: "blue rounded-tr-lg border-0"
        }
      ]
    };
  },
  mounted: async function() {
    this.getstakingtx();
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.truncate {
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
