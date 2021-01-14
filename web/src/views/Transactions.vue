<template>
  <div class="Transactions">
    <div>
      <v-card>
        <v-tabs background-color="white accent-4" center-active fixed-tabs>
          <v-tab>All</v-tab>
          <v-tab>Staking</v-tab>
          <v-tab>Contracts</v-tab>
          <v-tab>Payments</v-tab>

          <v-btn class="mx-0" dark color="success">
            <v-icon dark>
              mdi-plus
            </v-icon>
          </v-btn>

          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <p></p>

                <p>
                  <alltx />
                </p>
              </v-card-text>
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <p></p>

                <p>
                  <stakingtx />
                </p>
              </v-card-text>
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <p>
                  Sed aliquam ultrices mauris. Donec posuere vulputate arcu.
                  Morbi ac felis. Etiam feugiat lorem non metus. Sed a libero.
                </p>

                <p>
                  Nam ipsum risus, rutrum vitae, vestibulum eu, molestie vel,
                  lacus. Aenean tellus metus, bibendum sed, posuere ac, mattis
                  non, nunc. Aliquam lobortis. Aliquam lobortis. Suspendisse non
                  nisl sit amet velit hendrerit rutrum.
                </p>

                <p class="mb-0">
                  Phasellus dolor. Fusce neque. Fusce fermentum odio nec arcu.
                  Pellentesque libero tortor, tincidunt et, tincidunt eget,
                  semper nec, quam. Phasellus blandit leo ut odio.
                </p>
              </v-card-text>
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <p>
                  Sed aliquam ultrices mauris. Donec posuere vulputate arcu.
                  Morbi ac felis. Etiam feugiat lorem non metus. Sed a libero.
                </p>

                <p>
                  Nam ipsum risus, rutrum vitae, vestibulum eu, molestie vel,
                  lacus. Aenean tellus metus, bibendum sed, posuere ac, mattis
                  non, nunc. Aliquam lobortis. Aliquam lobortis. Suspendisse non
                  nisl sit amet velit hendrerit rutrum.
                </p>

                <p class="mb-0">
                  Phasellus dolor. Fusce neque. Fusce fermentum odio nec arcu.
                  Pellentesque libero tortor, tincidunt et, tincidunt eget,
                  semper nec, quam. Phasellus blandit leo ut odio.
                </p>
              </v-card-text>
            </v-card>
          </v-tab-item>
        </v-tabs>
      </v-card>

      <b-button variant="primary" href="#">More Info</b-button>
      <addCategory />
    </div>
  </div>
</template>

<script>
import alltx from "../components/tx/alltx.vue";
import stakingtx from "../components/tx/stakingtx.vue";
import addCategory from "../components/addCategory.vue";
export default {
  name: "Transactions",
  components: {
    alltx,
    stakingtx,
    addCategory
  }
};
</script>
<style type="text/css">
.transactions: {
  width: 100%;
}
</style>
