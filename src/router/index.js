import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
//import Dashboard from "../views/Dashboard.vue"
Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home
  },
  {
    path: "/Transactions",
    name: "Transactions",
    component: () => import("../views/Transactions.vue")
  },
  {
    path: "/Cards",
    name: "Cards",
    component: () => import("../views/Cards.vue")
  },
  {
    path: "/Migrate",
    name: "Migrate",
    component: () => import("../views/Migrate.vue")
  },
  {
    path: "/Wallets",
    name: "Wallets",
    component: () => import("../views/Wallets.vue")
  },
  {
    path: "/Exchanges",
    name: "Exchanges",
    component: () => import("../views/Exchanges.vue")
  },
  {
    path: "/Pools",
    name: "Pools",
    component: () => import("../views/Pools.vue")
  },
  {
    path: "/Delegations",
    name: "Delegations",
    component: () => import("../views/Delegations.vue")
  },
  {
    path: "/validators",
    name: "validators",
    component: () => import("../views/validators.vue")
  },
  {
    path: "/Contracts",
    name: "Contracts",
    component: () => import("../views/Contracts.vue")
  }
];

const router = new VueRouter({
  routes
});

export default router;
