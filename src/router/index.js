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
    path: "/Card",
    name: "Card",
    component: () => import("../views/Card.vue")
  },
  {
    path: "/Merchant",
    name: "Merchant",
    component: () => import("../views/Merchant.vue")
  },
  {
    path: "/Swap",
    name: "Swap",
    component: () => import("../views/Swap.vue")
  },
  {
    path: "/Pool",
    name: "Pool",
    component: () => import("../views/Pool.vue")
  },
  {
    path: "/Stake",
    name: "Stake",
    component: () => import("../views/Stake.vue")
  },
  {
    path: "/Preferences",
    name: "Preferences",
    component: () => import("../views/Preferences.vue")
  },
  {
    path: "/Statistics",
    name: "Statistics",
    component: () => import("../views/Statistics.vue")
  },
  {
    path: "/About",
    name: "About",
    component: () => import("../views/About.vue")
  }
];

const router = new VueRouter({
  routes
});

export default router;
