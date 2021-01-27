<template>
  <div class="About">
    <v-container>
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab width="100%">Ethereum To Harmony</v-tab>
        <v-tab>Harmony to Ethereum</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>
                ETH->HMY BRIDGE
              </p>

              <p></p>

              <p class="mb-0"></p>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>
                HMY->ETH BRIDGE
              </p>

              <p></p>

              <p class="mb-0"></p>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "About",
  components: {}
};
</script>
<style type="text/css"></style>
