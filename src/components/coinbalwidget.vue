<template>
  <div class="container">
    <div class="text-center">
      <v-progress-circular indeterminate color="purple" v-if="!loaded">
      </v-progress-circular>
    </div>

    <doughnut
      v-if="loaded"
      :chartdata="chartdata"
      :options="options"
      height="300px"
    />
  </div>
</template>

<script>
import store from "../store";
import hmy from "../javascript/hmy";

const { Units, numToStr, fromWei } = require("@harmony-js/utils");
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
        maintainAspectRatio: false,
        width: "250px"
      },
      chartColors: [
        "#EF5350",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        "#7E57C2",
        "#EF5350",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        " #7E57C2"
      ],
      tokenList: {
        tokenName: [
          "ARANK",
          "BUSD ",
          "EUSK ",
          "GOLD ",
          "LINK",
          "LMA  ",
          "ONES",
          "SEE ",
          "SEED",
          "USDs",
          "WETH"
        ],
        tokenAddr: [
          "0xBD16b0B2eB520b7Ff4A4156d367Ee359Ac19c531",
          "0xE176EBE47d621b984a73036B9DA5d834411ef734",
          "0x85a1DD919cd605aa2EAD4b01ff1190504BcAb609",
          "0x7aFB0E2ebA6Dc938945FE0f42484d3b8F442D0AC",
          "0x218532a12a389a4a92fC0C5Fb22901D1c19198aA",
          "0x7d0546dBb1Dca8108d99Aa389A8e9Ce0C40B2370",
          "0xB2f2C1D77113042f5ee9202d48F6d15FB99efb63",
          "0x7fA202fdb3B0eCB975119cc3A895BFB3104aDA68",
          "0x793DAC3Ec4969A5BEE684BcF4290d52feB8F51b4",
          "0x67e025BE82304F7D872cc8858285860223C217fB",
          "0xF720b7910C6b2FF5bd167171aDa211E226740bfe"
        ]
      }
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
      hmy.blockchain.getBalance({ address: store.state.address }).then(() => {
        dataarray.push(5); //fromWei(hexToNumber(response.result), Units.one)
        tokenname.push("One");
        this.chartdata.labels.push("ONE");
      });

      var i = 1;

      while (i < this.tokenList.tokenAddr.length) {
        await this.getTokenBalance(this.tokenList.tokenAddr[i]).then(
          tokenBalance => {
            if (tokenBalance > 0.000000000001) {
              this.chartdata.labels.push(this.tokenList.tokenName[i]);
              dataarray.push(tokenBalance);
              console.log("bal : " + tokenBalance + "i : " + i);
              tokenname.push(this.tokenList.tokenName[i]);
              console.log("push token : " + this.tokenList.tokenName[i]);
            }
          }
        );
        i++;
      }
      this.chartdata.datasets.push({
        label: tokenname,
        backgroundColor: this.chartColors,
        data: dataarray
      });
      console.log(this.chartdata);
      this.loaded = true;
    } catch (error) {
      console.error("coinbalwidget : " + error);
    }
  }
};
</script>
<style type="text/css" scoped></style>
