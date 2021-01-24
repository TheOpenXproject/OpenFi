<template>
  <div class="container">
    <div class="text-center">
      <v-progress-circular indeterminate color="purple" v-if="!loaded">
      </v-progress-circular>
    </div>

    <doughnut v-if="loaded" :chartdata="chartdata" :options="options" />
  </div>
</template>

<script>
import store from "../store";
import hmy from "../javascript/hmy";

const { Units, numToStr, fromWei, hexToNumber } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");
import doughnut from "./charts/doughnutChart.vue";

export default {
  name: "coinbalwidget",
  components: { doughnut },
  data() {
    return {
      loaded: false,
      chartdata: {
        labels: [],
        datasets: []
      },
      options: {
        responsive: true,
        maintainAspectRatio: false
      },
      chartColors: [
        "#89cff0",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        "#7E57C2",
        "#EF5350",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        " #7E57C2"
      ]
    };
  },
  methods: {
    getTokenBalance: async function(tokenAddr) {
      const wallet = store.state.wallet;
      let options = {
        gasPrice: 1000000000,
        gasLimit: 500000
      };
      const unattachedContract = await this.initializeContract(tokenAddr);
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .balanceOf(store.state.address)
        .call(options);
      const num = value;
      const str = numToStr(num);

      // fromWei
      const Wei = new BN(str);
      const expected = fromWei(Wei, Units.one);
      var number = parseFloat(expected);
      return number;
    },
    initializeContract: async function(HRCtoken) {
      const abi = [
        // balanceOf
        {
          constant: true,
          inputs: [{ name: "_owner", type: "address" }],
          name: "balanceOf",
          outputs: [{ name: "balance", type: "uint256" }],
          type: "function"
        },
        // decimals
        {
          constant: true,
          inputs: [],
          name: "decimals",
          outputs: [{ name: "", type: "uint8" }],
          type: "function"
        }
      ];
      const contractAddress = HRCtoken;
      const contractInstance = hmy.contracts.createContract(
        abi,
        contractAddress
      );
      return contractInstance;
    }
  },

  async mounted() {
    this.loaded = false;
    try {
      const dataarray = new Array();
      const tokenname = new Array();
      await hmy.blockchain
        .getBalance({ address: store.state.address })
        .then(response => {
          dataarray.push(fromWei(hexToNumber(response.result), Units.one)); //
          tokenname.push("One");
          this.chartdata.labels.push("ONE");
          store.commit(
            "setVTokenBalances",
            fromWei(hexToNumber(response.result), Units.one)
          );
        });

      var i = 1;

      while (i < store.state.validatedtokens.addr.length) {
        await this.getTokenBalance(store.state.validatedtokens.addr[i])
          .then(tokenBalance => {
            console.log(i);
            if (tokenBalance > 0.0000000001) {
              this.chartdata.labels.push(store.state.validatedtokens.symbol[i]);
              dataarray.push(tokenBalance);
              console.log(tokenBalance);
              tokenname.push(store.state.validatedtokens.symbol[i]);
            }
            store.commit("setVTokenBalances", tokenBalance);
          })
          .catch(error => console.log(error));

        i++;
      }
      this.chartdata.datasets.push({
        label: tokenname,
        backgroundColor: this.chartColors,
        data: dataarray
      });
      this.loaded = true;
    } catch (error) {
      console.error("coinbalwidget : " + error);
    }
  }
};
</script>
<style type="text/css" scoped></style>
