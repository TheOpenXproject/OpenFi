<template>
  <div class="Transactions">
    <v-container class="grey lighten-4">
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab>All</v-tab>
        <v-tab>Staking</v-tab>
        <v-tab>Contracts</v-tab>
        <v-tab>Payments</v-tab>

        <v-btn class="mx-0 mt-2 mr-2" dark color="green lighten-1">
          <v-icon dark>
            mdi-plus
          </v-icon>
        </v-btn>

        <v-tab-item>
          <p></p>

          <p>
            <alltx />
          </p>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p></p>

              <p>
                <stakingtx />
              </p>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <br /><br /><br /><br />
              <p>
                <center>coming soon...</center>
              </p>
            </v-card-text>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <br /><br /><br /><br />
              <center>coming soon...</center>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
      <addCategory />
    </v-container>
  </div>
</template>

<script>
import alltx from "../components/tx/alltx.vue";
import stakingtx from "../components/tx/stakingtx.vue";
import addCategory from "../components/addCategory.vue";
export default {
  name: "Transactions",
  components: {
    alltx,
    stakingtx,
    addCategory
  }
};
</script>
<style type="text/css">
.transactions: {
  width: 100%;
}
</style>
