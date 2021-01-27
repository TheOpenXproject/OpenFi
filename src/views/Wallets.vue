<template>
  <div class="Wallets">
    <b-container class="pt-5">
      <v-card small height="auto">
        <v-card-title small light shaped class="green lighten-1 white--text"
          >Harmony <v-spacer />+</v-card-title
        >
        <v-card-text>
          <v-container
            v-for="align in 2"
            :key="align"
            class="grey lighten-5 pa-6"
          >
            <v-row :align="align" no-gutters>
              <v-col v-for="n in 2" :key="n">
                <v-card class="" tile width="auto" height="auto">
                  <v-row class="text-center">
                    <v-row class="text-center"
                      ><v-container>name</v-container></v-row
                    >
                    <v-container>
                      <center>
                        <img height="100" src="../assets/wallet.png" />
                      </center>
                    </v-container>
                  </v-row>
                  <v-row class="text-center"
                    ><v-container
                      >one1r5er3r2snl3eseumfhhtsuafvdyfqredv5k750</v-container
                    ></v-row
                  >
                  <v-row class="text-center"
                    ><v-container>Balance 0.05</v-container></v-row
                  >
                  <v-row class="text-center"
                    ><v-container
                      >Verified
                      <v-icon class="ma-0">mdi-check</v-icon></v-container
                    ></v-row
                  >
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
      <v-card height="auto">
        <v-card-title small dark shaped class="green lighten-1 mt-3 white--text"
          >Ethereum<v-spacer />+</v-card-title
        >
        <v-card-text>
          <v-container
            v-for="align in 2"
            :key="align"
            class="grey lighten-5 pa-6"
          >
            <v-row :align="align" no-gutters>
              <v-col v-for="n in 2" :key="n">
                <v-card class="" tile height="auto">
                  <v-row class="text-center">
                    <v-row class="text-center"
                      ><v-container>name</v-container></v-row
                    >
                    <v-container>
                      <center>
                        <img class="" height="100" src="../assets/wallet.png" />
                      </center>
                    </v-container>
                  </v-row>
                  <v-row class="text-center"
                    ><v-container
                      >0xB02FbF1986D308A7C4E6626D5a7673DC09646dfe</v-container
                    ></v-row
                  >
                  <v-row class="text-center"
                    ><v-container>Balance 0.05</v-container></v-row
                  >
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </b-container>
  </div>
</template>

<script>
export default {
  name: "Wallets",
  components: {}
};
</script>
<style type="text/css"></style>
