<template>
  <v-app id="open.fi">
    <div class="error small">
      This is in active developement. Please Dont put money on the contracts you
      encouter here.
    </div>
    <div v-if="loggedIn">
      <v-app-bar app  class="green bar lighten-1">

        <v-toolbar-title
          ><img
            width="150px"
            class=""
            src="./assets/openfitrans.png"
          />
        </v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn color="error" v-on:click="logout">logout</v-btn>
      </v-app-bar>

      <v-navigation-drawer
        show
        absolute
        class="navigation grey navs lighten-4"
        bg-dark
        ><br /><br /><br />
        <v-container class="text-left pa-0 ">
          <v-card
            class="white lighten-1 grey--text bg-light"
            width="100%"
            height="50"
          >
            <router-link
              to="/"
              class="list-group-item list-group-item-action grey--text text--darken-1"
              >Dashboard<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/Wallets"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-2"
              >Wallets<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/Transactions"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Transactions<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>

          <v-card class="white lighten-1 " height="50"
            ><img
              src="./assets/right-arrow.png"
              height="20"
              class="float-right"/><router-link
              to="/Exchanges"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Exchanges
              <img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>

          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/migrate"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Migrate<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>

          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/Cards"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Cards<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>

          <v-card class="white lighten-1" height="50"
            ><router-link
              to="/Pools"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Liquidity Pools<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/Delegations"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Delegations<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/validators"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Validators<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
          <v-card class="white lighten-1 " height="50"
            ><router-link
              to="/Contracts"
              class="list-group-item list-group-item-action bg-light grey--text text--darken-1"
              >Contracts<img
                src="./assets/right-arrow.png"
                height="20"
                class="float-right"/></router-link
          ></v-card>
        </v-container>

        <!--  -->
      </v-navigation-drawer>

      <v-main relative>
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
    },
    isMobile() {
      if (
        /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
          navigator.userAgent
        )
      ) {
        return true;
      } else {
        return false;
      }
    }
  },

  data() {
    return {
      drawer: this.isMobile()
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
