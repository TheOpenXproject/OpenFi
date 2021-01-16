<template>
  <v-app id="open.fi">
    <div class="error small">
      This is in active developement. Please Dont put money on the contracts you
      encouter here.
    </div>
    <div v-if="loggedIn">
      <v-app-bar app fixed class="green lighten-2">
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

        <v-toolbar-title>Open.fi</v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn color="error" v-on:click="logout">logout</v-btn>
      </v-app-bar>

      <v-navigation-drawer
        v-model="drawer"
        fixed
        temporary
        class="navigation"
        bg-dark
      >
        <div class="list-group list-group-flush ">
          <div class="green lighten-2 pt-8"><center>OpenFi</center></div>
          <a
            ><router-link to="/" class="list-group-item list-group-item-action "
              >Dashboard</router-link
            ></a
          >
          <a
            ><router-link
              to="/Transactions"
              class="list-group-item list-group-item-action "
              >Transactions</router-link
            ></a
          >
          <a
            ><router-link
              to="/Card"
              class="list-group-item list-group-item-action "
              >Card</router-link
            ></a
          >
          <a
            ><router-link
              to="/Merchant"
              class="list-group-item list-group-item-action"
              >Merchant</router-link
            ></a
          >

          <a
            ><router-link
              to="/Swap"
              class="list-group-item list-group-item-action "
              >Swap</router-link
            ></a
          >
          <a
            ><router-link
              to="/Pool"
              class="list-group-item list-group-item-action bg-light"
              >Pool</router-link
            ></a
          >
          <a
            ><router-link
              to="/Stake"
              class="list-group-item list-group-item-action bg-light"
              >Stake</router-link
            ></a
          >
          <a
            ><router-link
              to="/Preferences"
              class="list-group-item list-group-item-action bg-light"
              >Preferences</router-link
            ></a
          >
          <a
            ><router-link
              to="/Statistics"
              class="list-group-item list-group-item-action bg-light"
              >Statistics</router-link
            ></a
          >
          <a
            ><router-link
              to="/About"
              class="list-group-item list-group-item-action bg-light"
              >About</router-link
            ></a
          >
        </div>

        <!--  -->
      </v-navigation-drawer>

      <v-main>
        <!--  -->
        <router-view />
      </v-main>
    </div>

    <v-container class="logincard" v-if="!loggedIn">
      <v-container pa-0>
        <v-row align="center" justify="center" style="height:95vh">
          <v-col
            cols="8"
            lg="8"
            md="8"
            class="white lighten-2 fill-height d-flex flex-column justify-center align-center"
          >
            <v-card class="elevation-20 rounded-xl" height="500" :width="width">
              <v-card-text>
                <h2 align="center" class="align-center" text-color="green">
                  OpenFi
                </h2>

                <center class="pt-10"><b>Sign in :</b></center>
                <br />
                <v-row>
                  <LedgerWalletLogin class="center" />

                  <OneWalletLogin class="center" />
                </v-row>
                <br /><br />
                <v-divider
                  class=" d-flex fill-height justify-center align-center"
                ></v-divider>

                <migrate />

                <v-divider
                  class=" d-flex fill-height justify-center align-center"
                ></v-divider>
                <createAccount />
                <v-divider
                  class=" d-flex fill-height justify-center align-center"
                ></v-divider>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-container>
  </v-app>
</template>

<script>
import OneWalletLogin from "./components/OneWalletLogin.vue";
import LedgerWalletLogin from "./components/LedgerWalletLogin.vue";
import createAccount from "./components/createAccount.vue";
import migrate from "./components/migrate.vue";
import store from "./store";

export default {
  name: "App",

  components: {
    OneWalletLogin,
    LedgerWalletLogin,
    createAccount,
    migrate
  },
  props: {},
  methods: {
    logout: async function() {
      await window.onewallet.forgetIdentity();
      store.commit("hasSignedIn", false);
    }
  },

  data() {
    return {
      drawer: null
    };
  },
  computed: {
    // a computed getter
    loggedIn: function() {
      // `this` points to the vm instance
      return store.state.signedIn;
    },
    width() {
      switch (this.$vuetify.breakpoint.name) {
        case "xs":
          return;
        case "sm":
          return "100px";
        case "md":
          return "300px";
        case "lg":
          return 275;
        case "xl":
          return 300;
      }
      return 0;
    }
  }
};
</script>
<style type="text/css">
.center {
  margin: auto;
  width: 50%;
  padding: 10px;
  text-align: center;
}
.createAccount {
  position: center;
  text-align: center;
}
.logo {
  vertical-align: middle;
  text-align: center;
  font-weight: 300;

  font-size: 50px;
  position: absolute;
}
</style>
