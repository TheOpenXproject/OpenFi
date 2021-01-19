import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    signedIn: false,
    address: null,
    addresses: null,
    userContract: null,
    wallet: null,
    onebal: null,
    busdbal: null,
    wonebal: null,
    linkbal: null,
    s0: null,
    s1: null,
    s2: null,
    s3: null,
    totatonebal: null,
    OPENFI: "0x2645B6ab1047d5fAe66c02B18E2A693515546fCF",
    userManagerAddr: null,
    userWalletAddr: null,
    userBudgetAddr: null,
    userTokenAddr: null
  },
  mutations: {
    hasSignedIn(state, hasSignedIn) {
      state.signedIn = hasSignedIn;
    },

    //
    //TOKEN BALANCES
    //

    setShard1Balance(state, s0) {
      state.s0 = s0;
    },
    setShard2Balance(state, s1) {
      state.s1 = s1;
    },
    setShard3Balance(state, s2) {
      state.s2 = s2;
    },
    setShard4Balance(state, s3) {
      state.s3 = s3;
    },
    setTotalOneBal(state) {
      state.totalonebal = state.s0 + state.s1 + state.s2 + state.s3;
    },
    setOneBal(state, onebalance) {
      state.onebal = onebalance;
    },
    setWoneBal(state, wonebalance) {
      state.wonebal = wonebalance;
    },

    setBusdBal(state, busdbalance) {
      state.busdbal = busdbalance;
    },

    setLinkBal(state, linkbalance) {
      state.linkbal = linkbalance;
    },

    //
    //USERDATA
    //

    setUserAddress(state, address) {
      state.address = address;
    },
    setUserAddresses(state, addresses) {
      state.addresses = addresses;
    },
    setUserContract(state, address) {
      state.userContract = address;
    },
    setUserWallet(state, wallet) {
      state.wallet = wallet;
    },
    setUserWalletAddr(state, address) {
      state.userWalletAddr = address;
    },
    setUserManagerAddr(state, address) {
      state.userManagerAddr = address;
    },
    setUserBudgetAddr(state, address) {
      state.userBudgetAddr = address;
    },
    setUserTokenAddr(state, address) {
      state.userTokenAddr = address;
    }
  },
  actions: {},
  modules: {}
});
