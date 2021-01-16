<template>
  <div class="home">
    <v-container class="grey lighten-4">
      <h3 class="mt-5 ml-5">Dashboard</h3>

      <v-divider class="green lighten-1" />
      <v-row no-gutters class="rounded-xl">
        <v-col cols="6" md="4">
          <v-card class="pa-4 rounded-l-xl" height="100%" tile>
            <coinbalwidget />
          </v-card>
        </v-col>
        <v-col cols="12" sm="6" md="8">
          <v-card class="pa-2 rounded-r-xl" height="100%">
            <v-container>
              <v-row>
                <h4>Assets / Tokens</h4>
                <v-spacer></v-spacer>
                <v-btn class="mx-2" fab dark color="blue">
                  <v-icon dark>
                    mdi-plus
                  </v-icon>
                </v-btn>
              </v-row>
              <v-row>
                <v-col cols="2" sm="6" md="4">
                  <v-btn fab dark large class="green lighten-2"> los </v-btn>|
                  3.95$
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
      </v-row>

      <v-row no-gutters class="mt-3">
        <v-col cols="6" md="4">
          <v-card class="pa-2" outlined tile>
            <shardwidget width="250px" />
          </v-card>
        </v-col>
        <v-col cols="12" sm="6" md="8">
          <v-card class="pa-2 rounded-r-xl" outlined tile height="100%">
            Shard Balances
          </v-card>
        </v-col>
      </v-row>

      <v-row>
        <v-col
          cols="12"
          lg="12"
          md="12"
          class="white center lighten-2 rounded-xl mt-1"
        >
          <alltx />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

// @ is an alias to /src
//import HelloWorld from "@/components/HelloWorld.vue";
import alltx from "../components/tx/alltx.vue";
import shardwidget from "../components/shardwidget.vue";
import coinbalwidget from "../components/coinbalwidget.vue";

//import store from "../store"

export default {
  name: "Home",
  components: {
    shardwidget,
    coinbalwidget,
    alltx
  },

  data() {
    return {};
  }
};
</script>
<style>
.pa-2 {
  border: 5px;
  border-color: #66bb6a;
}
</style>
