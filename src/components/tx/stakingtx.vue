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
                id: n + 1,
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
      CategoryDialogData: null,
      headers: [
        {
          text: "#",
          align: "start",
          sortable: false,
          value: "id",
          class: "green lighten-1 rounded-tl-lg border-0"
        },

        { text: "date", value: "time", class: "green lighten-1  border-0" },
        { text: "From", value: "from", class: "green lighten-1  border-0" },
        { text: "To ", value: "to", class: "green lighten-1  border-0" },
        {
          text: "Amount",
          value: "value",
          class: "green lighten-1 rounded-tr-lg  border-0"
        }
        /*{
          text: "category ",
          value: "category",
          class: "green lighten-1  rounded-tr-lg border-0"
        }*/
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
  max-width: 120px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
