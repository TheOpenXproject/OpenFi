<script>
import { Doughnut } from "vue-chartjs";
import store from "../store";

export default {
  extends: Doughnut,

  mounted() {
    this.renderChart(this.chartdata, this.options);
  },

  data() {
    return {
      chartdata: {
        labels: ["One", "Busd", "Wone", "Link"],
        datasets: [
          {
            backgroundColor: ["#03A9F4", "#FF1744", "#5sd57d", "#FDD835"],
            data: [
              store.state.onebal,
              store.state.busdbal,
              store.state.wonebal,
              store.state.linkbal
            ]
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    };
  }
};
</script>

<style></style>

<style></style>
