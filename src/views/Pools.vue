<template>
  <div class="Pools">
    <b-container>
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab>OpenFi Pools</v-tab>
        <v-tab>Swoop Pools</v-tab>
        <v-tab>SeeSwap Pools</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>
                OFI Pools
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
                Swoop Pools
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
                SeeSwap Pools
              </p>

              <p></p>

              <p class="mb-0"></p>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </b-container>
  </div>
</template>

<script>
export default {
  name: "Pools",
  components: {}
};
</script>
<style type="text/css"></style>
