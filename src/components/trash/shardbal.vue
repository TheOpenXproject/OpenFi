<template>
  <div class="shardbal">
    <line-chart :chartData="datacollection"></line-chart>
    <button @click="fillData()">Randomize</button>
  </div>
</template>
<script>
import { Bar } from "vue-chartjs";
import store from "../store";
const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");
import LineChart from "./charts/LineChart.js";

export default {
  extends: Bar,
  components: {
    LineChart
  },
  data() {
    return {
      totalBalance: 0,
      datacollection: null,
      chartdata: {
        labels: ["Shard 1", "Shard 2", "Shard 3", "Shard 4"],
        datasets: [
          {
            label: "Shard 1",
            barPercentage: 0.5,
            barThickness: 30,
            maxBarThickness: 50,
            minBarLength: 7,
            backgroundColor: "#03A9F4",
            data: [store.state.s0, this.s1, this.s2, store.state.s3]
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: true
      }
    };
  },
  created() {},

  mounted() {
    this.setshardbalance();
    this.setTotalBalance();
    this.fillData();
    setTimeout(function() {
      this.$data._chart.update();
    }, 2000);
  },
  methods: {
    fillData() {
      this.datacollection = {
        labels: ["s1", "s2"],
        datasets: [
          {
            label: "s0",
            backgroundColor: "#f87979",
            data: [this.s1, this.getRandomInt()]
          },
          {
            label: "s1",
            backgroundColor: "#f87979",
            data: [this.getRandomInt(), this.getRandomInt()]
          }
        ]
      };
    },

    getRandomInt() {
      return Math.floor(Math.random() * (50 - 5 + 1)) + 5;
    },
    setTotalBalance: async function() {
      store.commit("setTotalOneBalance");
    },
    getshard1balance: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getBalance",
        params: [store.state.address]
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

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          this.s1 = parseInt(expected);
        })
        .catch(error => console.log("error", error));
      this.$data._chart.update();
    },
    getshard2balance: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getBalance",
        params: [store.state.address]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://rpc.s1.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          store.commit("setShard2Balance", parseInt(expected));
        })
        .catch(error => console.log("error", error));
    },
    getshard3balance: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getBalance",
        params: [store.state.address]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://rpc.s2.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);

          this.s2 = parseInt(expected);
        })
        .catch(error => console.log("error", error));
    },
    getshard4balance: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getBalance",
        params: [store.state.address]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://rpc.s3.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);
          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          store.commit("setShard4Balance", parseInt(expected));
        })
        .catch(error => console.log("error", error));
    },
    setshardbalance: async function() {
      await this.getshard1balance();
      await this.getshard2balance();
      await this.getshard3balance();
      await this.getshard4balance();
    }
  }
};
</script>

<style></style>

<style>
.small {
  max-width: 250px;
  margin: 250px auto;
}
</style>
