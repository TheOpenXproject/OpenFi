<template>
  <div class="Exchanges">
    <v-container>
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab>OpenFi</v-tab>
        <v-tab>Swoop</v-tab>
        <v-tab>SeeSwap</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <p>
                OFI exchange
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
                Swoop exchange
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
                SeeSwap Exchange
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
  name: "Exchanges",
  components: {}
};
</script>
<style type="text/css"></style>
