<template>
  <div class="Swap">
    <sidebar />
    <b-container>
      <div>
        <b-jumbotron lead="">
          <v-card>
            <v-tabs background-color="white accent-4" center-active fixed-tabs>
              <v-tab>SeeSwap</v-tab>
              <v-tab>Open.Fi</v-tab>

              <v-tab-item>
                <v-card flat>
                  <v-card-text>
                    <p>
                      SeeSwap exchange
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
                      open.fi Exchange
                    </p>

                    <p></p>

                    <p class="mb-0"></p>
                  </v-card-text>
                </v-card>
              </v-tab-item>
            </v-tabs>
          </v-card>
        </b-jumbotron>
      </div>
    </b-container>
  </div>
</template>

<script>
export default {
  name: "Swap",
  components: {}
};
</script>
<style type="text/css"></style>
