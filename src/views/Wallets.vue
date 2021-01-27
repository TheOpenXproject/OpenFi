<template>
  <div class="Wallets">
    <b-container class="pt-5">
      <v-card small height="auto">
        <v-card-title small light shaped class="green lighten-1 white--text">Harmony <v-spacer/>+</v-card-title>
        <v-card-text>

          <v-container
                v-for="align in 2"
                :key="align"
                class="grey lighten-5 mb-6"
              >
                <v-row
                  :align="align"
                  no-gutters
                  style="height: 150px;"
                >
                  <v-col
                    v-for="n in 3"
                    :key="n"
                  >
                    <v-card
                      class="pa-2"
                      outlined
                      tile
                      height="200"
                    >
                      WALLET
                    </v-card>
                  </v-col>
                </v-row>
              </v-container>

          
        </v-card-text>
      </v-card>
      <v-card height="200">
        <v-card-title small dark shaped class="green lighten-1 mt-3 white--text">Ethereum<v-spacer/>+</v-card-title>
        <v-card-text>
          
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
