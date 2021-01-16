<template>
  <div class="LedgerWalletLogin">
    <v-btn class="mx-2" fab dark text large color="white">
      <v-img
        src="../assets/ledger.png"
        v-on:click="initLedgerWallet"
        alt=""
        contain
        height="40px"
        width="40px"
      >
      </v-img>
    </v-btn>
  </div>
</template>

<script>
import hmy from "../javascript/hmy";
import store from "../store";
//import Ledger from "../javascript/ledger.js";
import TransportWebUSB from "@ledgerhq/hw-transport-webusb";
import contract from "../../build/contracts/UserFactory.json";
//import TransportU2F from '@ledgerhq/hw-transport-u2f';
import HarmonyApp from "../javascript/ledger.js";
//import hmy from '../javascript/hmy.js';

//var fs = require("fs");
export default {
  name: "LedgerWalletLogin",
  props: {
    msg: String
  },
  methods: {
    log(msg) {
      this.deviceLog.push({
        index: this.deviceLog.length,
        msg
      });
    },
    async getTransport() {
      let transport = null;

      try {
        transport = await TransportWebUSB.create();
      } catch (e) {
        this.log(e);
      }
      console.log(transport);

      return transport;
    },
    async initLedgerWallet() {
      this.deviceLog = [];
      // Given a transport (U2F/HIF/WebUSB) it is possible instantiate the app
      const transport = await this.getTransport();
      const app = new HarmonyApp(transport);
      // now it is possible to access all commands in the app
      const response = await app.publicKey(true);
      if (response.return_code !== 0x9000) {
        this.log(`Error [${response.return_code}] ${response.error_message}`);
        return;
      }
      const address = response.one_address.toString();
      console.log(address);
      this.log("Harmony one address for ledger is:");
      store.commit("setUserAddress", address);
      await this.getUserContract();
      this.log(address);
    },

    getUserContract: async function() {
      const unattachedContract = await this.initializeContract();
      const contract = this.attachToContract(unattachedContract);
      const value = await contract.methods
        .getUserContractAddress("one1r5er3r2snl3eseumfhhtsuafvdyfqredv5k750")
        .call();
      console.log(value);
      store.commit("setUserContract", value);
    },
    initializeContract: async function() {
      const abi = contract.abi;
      const contractAddress = "0x1D32388D509Fe398679B4dEEb873a96348900f2d";
      const contractInstance = hmy.contracts.createContract(
        abi,
        contractAddress
      );
      console.log(contractInstance);
      return contractInstance;
    },

    attachToContract(contract) {
      contract.wallet.signTransaction = async txn => {
        txn.from = store.state.address;
        const transport = await this.getTransport();
        const app = new HarmonyApp(transport);
        const signTx = await app.signTx(txn);

        return signTx;
      };

      return contract;
    }
  },
  data() {
    return {
      deviceLog: []
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
