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
    OPENFI: "0xadf16A5aCDc8cD2e59b94d18A90878Ee5AD67031",
    userManagerAddr: null,
    userWalletAddr: null,
    userBudgetAddr: null,
    userTokenAddr: null,
    isDataLoaded: false,
    metamaskaddress: null,
    validatedtokens: {
      name: [
        "One",
        "Binance USD",
        "Wrapped Btc",
        "Wrapped Eth",
        "Wrapped One",
        "ChainLink",
        "Seed",
        "Aave",
        "Yfi"
      ],
      symbol: [
        "ONE",
        "BUSD",
        "1WBTC",
        "1WETH",
        "WONE",
        "LINK",
        "SEED",
        "AAVE",
        "YFI"
      ],
      addr: [
        "0x0",
        "0xE176EBE47d621b984a73036B9DA5d834411ef734",
        "0x3095c7557bCb296ccc6e363DE01b760bA031F2d9",
        "0xF720b7910C6b2FF5bd167171aDa211E226740bfe",
        "0xcF664087a5bB0237a0BAd6742852ec6c8d69A27a",
        "0x218532a12a389a4a92fC0C5Fb22901D1c19198aA",
        "0x793DAC3Ec4969A5BEE684BcF4290d52feB8F51b4",
        "0xcF323Aad9E522B93F11c352CaA519Ad0E14eB40F",
        "0xa0dc05F84A27FcCBD341305839019aB86576bc07"
      ],
      balances: [],
      colors: [
        "#89cff0",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        "#7E57C2",
        "#EF5350",
        "#EC407A",
        "#AB47BC",
        "#7E57C2",
        "#7E57C2"
      ]
    }
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
    setVTokenBalances(state, tokenamount) {
      state.validatedtokens.balances.push(tokenamount);
    },

    //
    //USERDATA
    //

    setMetamaskAddress(state, address) {
      state.metamaskaddress = address;
    },

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
    },
    setDataLoaded(state, nowisitqmark) {
      state.isDataLoaded = nowisitqmark;
    }
  },
  actions: {},
  modules: {}
});
