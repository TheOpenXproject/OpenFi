<template>
  <div class="alltx rounded-lg">
    <v-data-table
      :headers="headers"
      :items="eventTableData"
      item-key="name"
      class="table rounded-xl table-striped"
      reactive
      height="100%"
      v-if="this.isLoaded == true"
      no-scroll
    >
      <template v-slot:item="{ item }">
        <tr class="text-center">
          <td class="">{{ item.id }}</td>
          <td overflow-hidden flex class="">{{ item.time }}</td>
          <td class="">{{ item.from }}</td>
          <td class="">{{ item.to }}</td>
          <td class="truncate">{{ item.value }}</td>

          <td class="" v-if="item.category != null">
            <v-chip color="green lighten-2" dark class="mt-2">
              {{ item.category }}
            </v-chip>
          </td>
          <td v-if="item.category == null">
            <center><addCategory :item="item" class="mt-1" /></center>
          </td>
        </tr>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import store from "../../store";

import hmy from "../../javascript/hmy";
import UserBudgetContract from "../../../build/contracts/UserBudgetContract.json";
import addCategory from "../addCategory.vue";
const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");

export default {
  name: "alltx",
  props: {
    msg: String
  },
  components: {
    addCategory
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
      // let options2 = { gasPrice: 1000000000, gasLimit: 21000 };

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://api.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(async result => {
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
              var cat = await this.getTxCategory(data.hash);
              this.eventTableData.push({
                id: n + 1,
                txid: data.hash,
                time: time,
                from: data.from,
                to: data.to,
                value: expected,
                category: cat
              });

              n++;
            }
          }
        })
        .catch(error => console.log("error", error));
    },
    getTxCategory: async function(txid) {
      const wallet = store.state.wallet;

      const unattachedContract = await this.initializeContract(
        UserBudgetContract,
        store.state.userBudgetAddr
      );
      const contract = wallet.attachToContract(unattachedContract);

      const category = await contract.methods.getTxCategory(txid).call();
      if (category != "") {
        return category;
      }
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
  data() {
    return {
      dialogCat: null,
      isLoaded: false,
      txids: null,
      categories: null,
      eventTableData: [],
      headers: [
        {
          text: "#",
          align: "start",
          sortable: true,
          value: "id",
          class: "green lighten-1 rounded-tl-lg border-0"
        },

        { text: "date", value: "time", class: "green lighten-1 border-0" },
        { text: "From", value: "from", class: "green lighten-1 border-0" },
        { text: "To ", value: "to", class: "green lighten-1 border-0" },
        { text: "Amount", value: "value", class: "green lighten-1 border-0" },
        {
          text: "category ",
          value: "category",
          class: "green lighten-1 rounded-tr-lg border-0"
        }
      ]
    };
  },
  mounted: async function() {
    try {
      this.isLoaded = true;
      await this.getalltx();
    } catch (error) {
      console.log(error);
    }
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

.table-striped > tbody > tr:nth-child(2n + 1) > td,
.table-striped > tbody > tr:nth-child(2n + 1) > th {
  background-color: #bbdefb;
}
</style>
