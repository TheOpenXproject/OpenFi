<template>
  <div class="allvalidators rounded-lg">
    <v-container>
      <div v-if="!isLoaded">
        <v-progress-linear indeterminate></v-progress-linear>
      </div>
      <div v-if="isLoaded">
        <v-row cols="12" md="6">
          <v-card
            width="31%"
            height="auto"
            class="m-2"
            v-for="items in validatordata"
            v-bind:key="items.key"
          >
            <v-card-title class="green lighten-1">
              <v-spacer></v-spacer> {{ items.name }} <v-spacer></v-spacer>
            </v-card-title>
            <v-card-text>
              <br />
              <img
                width="100px"
                :src="
                  'https://api.stake.hmny.io/networks/mainnet/validators/' +
                    items.address +
                    '/avatar'
                "
              />
              <br />

              <br />

              address : <small>{{ items.address }} </small>

              <br />

              status : {{ items.status }}
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer
              ><v-btn class="green lighten-1">delegate</v-btn
              ><v-spacer></v-spacer>
            </v-card-actions>
          </v-card>
        </v-row>
      </div>
    </v-container>
  </div>
</template>

<script>
//import store from "../../store";

//import hmy from "../../javascript/hmy";

//const { Units, numToStr, fromWei } = require("@harmony-js/utils");
//const { BN } = require("@harmony-js/crypto");

export default {
  name: "alltx",
  props: {
    msg: String
  },
  components: {},
  methods: {
    getblocknumber: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_blockNumber",
        params: []
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(results => {
          results = JSON.parse(results);
          this.blocknumber = results.result;
        })
        .catch(error => console.log("error", error));
    },
    getallvalidators: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getAllValidatorInformationByBlockNumber",
        params: [-1, this.blocknumber - 1]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      await fetch("https://rpc.s0.t.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          const results = JSON.parse(result);
          var i = 0;
          console.log(results);
          while (i < results.result.length) {
            if (results.result[i]["active-status"] != "inactive") {
              this.validatordata.push({
                name: results.result[i].validator.name,
                status: results.result[i]["active-status"],
                pos_status: results.result[i]["epos-status"],
                address: results.result[i].validator.address
              });
            }

            i++;
          }
        })
        .catch(error => console.log("error", error));

      console.log("data    :     " + this.validatordata);
    }
  },

  data() {
    return {
      blocknumber: null,
      dialogCat: null,
      isLoaded: false,
      txids: null,
      categories: null,
      eventTableData: [],
      validatordata: [],
      headers: [
        {
          text: "#",
          align: "start",
          sortable: true,
          value: "id",
          class: "green lighten-1 rounded-tl-lg border-0"
        },

        { text: "date", value: "time", class: "green lighten-1 border-0" },
        { text: "From", value: "from", class: "green lighten-1 border-0" },
        { text: "To ", value: "to", class: "green lighten-1 border-0" },
        { text: "Amount", value: "value", class: "green lighten-1 border-0" },
        {
          text: "category ",
          value: "category",
          class: "green lighten-1 rounded-tr-lg border-0"
        }
      ]
    };
  },
  mounted: async function() {
    await this.getblocknumber();
    await this.getallvalidators();
    this.isLoaded = true;
  }
};
</script>

<style scoped>
.truncate {
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
