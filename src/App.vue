<template>
  <v-app id="open.fi">
    <div class="error small">
      This is in active developement. Please Dont put money on the contracts you
      encouter here.
    </div>
    <div v-if="loggedIn">
      <v-app-bar app fixed class="green lighten-1">
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

        <v-toolbar-title
          ><img width="120px" src="./assets/openfitrans.png" />
        </v-toolbar-title>

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
        <div class="list-group">
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
      <v-container>
        <v-row align="center" justify="center" style="height:95vh">
          <v-col
            cols="12"
            lg="4"
            md="4"
            class="white lighten-2 fill-height d-flex flex-column justify-center align-center"
          >
            <v-card class="elevation-6 rounded-xl" height="500">
              <v-card-text>
                <center>
                  <img width="200px" src="./assets/openfitrans.png" />
                </center>
                <v-divider
                  class=" d-flex fill-height justify-center align-center"
                ></v-divider>
                <br /><br />
                <center><Login /></center>
                <br /><br />
                <v-divider
                  class=" d-flex fill-height justify-center align-center"
                ></v-divider>
                <migrate />
                <br />
                <createAccount />
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-container>
  </v-app>
</template>

<script>
import Login from "./components/login.vue";
import createAccount from "./components/createAccount.vue";
import migrate from "./components/migrate.vue";
import store from "./store";

export default {
  name: "App",

  components: {
    Login,
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
    }
  }
};
</script>
<style type="text/css"></style>
