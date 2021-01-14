<template>
  <div class="alltx rounded-lg">
    <v-data-table
      dense
      :headers="headers"
      :items="eventTableData"
      item-key="name"
      class="table rounded-xl table-striped"
      reactive
      flat
    >
      <template v-slot:item="{ item }">
        <tr>
          <td class="truncate">{{ item.id }}</td>
          <td class="">{{ item.time }}</td>
          <td class="">{{ item.from }}</td>
          <td class="">{{ item.to }}</td>
          <td class="">{{ item.value }}</td>

          <td class="">
            {{ item.category }}
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
  name: "alltx",
  props: {
    msg: String
  },

  methods: {
    getalltx: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getTransactionsHistory",
        params: [
          {
            address: store.state.address,
            pageIndex: 0,
            pageSize: 50,
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

      fetch("https://api.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);
          result = result.result.transactions;
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

              // numberToString
              const num = data.value;
              const str = numToStr(num);
              // console.log(str);
              // fromWei
              const Wei = new BN(str);
              const expected = fromWei(Wei, Units.one);
              //console.log(expected);

              this.eventTableData.push({
                id: n + 1,
                txid: data.id,
                time: time,
                from: data.from,
                to: data.to,
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
      headers: [
        {
          text: "#",
          align: "start",
          sortable: true,
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
    this.getalltx();
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

.table-striped > tbody > tr:nth-child(2n + 1) > td,
.table-striped > tbody > tr:nth-child(2n + 1) > th {
  background-color: #bbdefb;
}
</style>
