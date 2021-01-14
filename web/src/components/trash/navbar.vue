<template>
  <div class="navbar">
    <v-toolbar shrink-on-scroll>
      <v-navigation-drawer v-model="drawer" app>
        <!--  -->
      </v-navigation-drawer>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>

      <v-toolbar-title>Application</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
        <createAccount />
        <getTxCategories />
        <login />
      </v-btn>
    </v-toolbar>
  </div>
</template>

<script>
import login from "./login.vue";
import createAccount from "./createAccount.vue";
import getTxCategories from "./getTxCategories.vue";

export default {
  name: "navbar",
  props: {
    msg: String
  },
  components: {
    login,
    createAccount,
    getTxCategories
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
