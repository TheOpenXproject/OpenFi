<template>
  <div class="mytokens">
    <v-card class="grey lighten-4 pb-10" flat height="600px">
      <v-card-title class="green lighten-1 white--text rounded-t-lg"
        >Portfolio<v-spacer></v-spacer>
        <v-btn fab dark small class="float-right blue">
          +
        </v-btn></v-card-title
      >
      <v-row class="rounded-xl">
        <v-col cols="6" v-if="(loaded = true)">
          <v-card
            class="rounded-xl"
            v-for="index in vtokenName.length"
            :key="index"
          >
            <v-row class="mt-4" v-if="vtokenBal[index - 1] > 0">
              <v-col>
                <v-btn
                  class="ml-3"
                  fab
                  dark
                  large
                  :style="{ 'background-color': tokencolors[index - 1] }"
                >
                  {{ vtokenSymb[index - 1] }}
                </v-btn>
              </v-col>
              <v-col>
                <v-row class="pt-6">
                  <b>{{ vtokenName[index - 1] }} </b>
                </v-row>
                <v-row class="pt-2 truncate" overflow-hidden>
                  {{ vtokenBal[index - 1] }}
                </v-row>
              </v-col>
              <v-col class="pt-6" overflow-hidden>
                3.90$
              </v-col>

              <div class=""></div>
            </v-row>
          </v-card>
        </v-col>
        <v-divider vertical></v-divider>
        <v-col cols="">
          <small></small>
        </v-col>
      </v-row>
    </v-card>
  </div>
</template>

<script>
//import store from "../store"

// @ is an alias to /src
//import HelloWorld from "@/components/HelloWorld.vue";

import store from "../store";

export default {
  name: "mytokens",
  components: {},
  props: {},

  data() {
    return {
      loaded: false,
      vtokenName: store.state.validatedtokens.name,
      vtokenBal: store.state.validatedtokens.balances,
      vtokenSymb: store.state.validatedtokens.symbol,
      tokencolors: store.state.validatedtokens.colors
    };
  },
  methods: {
    async mounted() {
      this.loaded = false;
    }
  }
};
</script>
<style>
.pa-2 {
  border: 5px;
  border-color: #66bb6a;
}
.truncate {
  width: 75px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
