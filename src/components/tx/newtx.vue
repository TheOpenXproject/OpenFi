<template>
  <div class="newtx">
    <template>
      <v-row justify="center">
        <v-dialog v-model="dialog" persistent max-width="600px">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              class="ma-2 mt-4 mr-4"
              color="green lighten-1"
              dark
              v-bind="attrs"
              v-on="on"
            >
              <v-icon dark>
                mdi-plus
              </v-icon>
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">New Transaction</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row cols="7" md="7">
                  <v-col cols="7" sm="7" md="7">
                    <v-autocomplete
                      :items="[
                        'OpenFi Dev (one1r5er3r2snl3eseumfhhtsuafvdyfqredv5k750)',
                        'Other'
                      ]"
                      label="To Address"
                    ></v-autocomplete>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      label="Amount"
                      hint="Enter how much you want to send"
                    ></v-text-field>
                  </v-col>

                  <v-col cols="8">
                    <v-text-field label="Tags (public)"></v-text-field>
                  </v-col>
                  <v-col cols="4">
                    <v-btn class="green lighten-1 mt-2">add tag</v-btn>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      label="Message (public)"
                      type="text-box"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-select
                      :items="[
                        'Payment',
                        'Donation',
                        'Helping out',
                        'Gift',
                        'Debt Collection'
                      ]"
                      label="Category (public)"
                      required
                    ></v-select>
                  </v-col>
                  <v-col cols="12" sm="6"> </v-col>
                </v-row>
              </v-container>
              <small>*indicates required field</small>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="dialog = false">
                Close
              </v-btn>
              <v-btn color="blue darken-1" text @click="dialog = false">
                Send
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-row>
    </template>
  </div>
</template>

<script>
export default {
  name: "newtx",
  components: {},
  data() {
    return {
      dialog: 0
    };
  }
};
</script>
<style type="text/css"></style>
