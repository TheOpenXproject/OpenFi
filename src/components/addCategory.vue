<template>
  <div class="addCategory">
    <v-row justify="center">
      <v-dialog max-width="600px">
        <template v-slot:activator="{ on, attrs }">
          <v-chip
            color="green lighten-2"
            dark
            v-bind="attrs"
            v-on="on"
            class="mt-4 "
          >
            +
          </v-chip>
        </template>
        <v-card>
          <v-card-title>
            <span class="headline">New Category</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12" sm="6" overflow
                  >Hash: <br />
                  {{ item.txid }}
                </v-col>
                <v-col cols="12" sm="6">
                  <v-autocomplete
                    :items="[
                      'Sent to friend',
                      'Car Payements',
                      'Rent',
                      'Food',
                      'Housing',
                      'Fees',
                      'Alimony(poor dads)',
                      'Saving',
                      'Insurance'
                    ]"
                    label="Category"
                    v-model="category"
                  ></v-autocomplete>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" sm="6" overflow
                  >To : <br />
                  {{ item.to }}
                </v-col>
                <v-col cols="12" sm="6"
                  >Amount : <br />
                  {{ item.value }}
                </v-col>
              </v-row>
            </v-container>
            <small>All Fields Required *</small>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn color="blue darken-1" text v-on:click="addCategory()">
              Save
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </div>
</template>

<script>
//import hmy from "../javascript/hmy";

import store from "../store";
import hmy from "../javascript/hmy";

import contract from "../../build/contracts/UserBudgetContract.json"; //this is up to date when it loads (call fuctions work elwere like this Just in case))
//var fs = require("fs");
export default {
  name: "addCategory",
  props: {
    msg: String,
    item: null
  },
  methods: {
    addCategory: async function() {
      const wallet = store.state.wallet;

      let txids = this.item.txid;
      let categories = this.category;

      let options = {
        gasPrice: 1000000000,
        gasLimit: 210000
      };
      const unattachedContract = await this.initializeContract();
      const contract = wallet.attachToContract(unattachedContract);
      await contract.methods.setTxCategory(txids, categories).send(options); //this passes
    },
    initializeContract: async function() {
      const abi = contract.abi;
      const contractAddress = store.state.userBudgetAddr;
      const contractInstance = hmy.contracts.createContract(
        abi,
        contractAddress
      );
      return contractInstance;
    }
  },
  data() {
    return {
      attrs: null,
      on: null,
      category: "",
      dialogCat: null
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
