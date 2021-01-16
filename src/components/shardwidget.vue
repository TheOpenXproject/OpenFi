<template>
  <div class="container">
    <div class="text-center">
      <v-progress-circular indeterminate color="primary" v-if="!loaded">
      </v-progress-circular>
    </div>
    <LineChart v-if="loaded" :chartdata="chartdata" :options="options" />
  </div>
</template>

<script>
import LineChart from "./charts/BarChart.vue";
import store from "../store";
const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");

export default {
  name: "ChartContainer",
  components: { LineChart },
  data: () => ({
    loaded: false,
    chartdata: {
      labels: [],
      datasets: []
    },
    options: {
      responsive: true,
      maintainAspectRatio: false
    }
  }),
  async mounted() {
    this.loaded = false;
    try {
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

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          var s0 = parseFloat(expected);

          this.chartdata.datasets.push({
            label: "Shard 0",
            backgroundColor: "#4DB6AC",
            data: [s0]
          });
        });

      await fetch("https://rpc.s1.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          var s1 = parseInt(expected);

          this.chartdata.datasets.push({
            label: "Shard 1",
            backgroundColor: "#43A047",
            data: [s1]
          });
        });

      await fetch("https://rpc.s2.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          var s2 = parseInt(expected);

          this.chartdata.datasets.push({
            label: "Shard 2",
            backgroundColor: "#64B5F6",
            data: [s2]
          });
        });

      await fetch("https://rpc.s3.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result.result;
          const str = numToStr(num);

          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          var s3 = parseInt(expected);

          this.chartdata.datasets.push({
            label: "Shard 3",
            backgroundColor: "#FFA726",
            data: [s3]
          });
        });
      this.loaded = true;
    } catch (e) {
      console.error("error : " + e);
    }
  }
};
</script>
