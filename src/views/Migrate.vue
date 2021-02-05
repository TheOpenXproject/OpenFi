<template>
  <div class="About">
    <v-container>
      <v-tabs background-color="white accent-4" center-active fixed-tabs>
        <v-tab width="100%">Ethereum To Harmony</v-tab>
        <v-tab>Harmony to Ethereum</v-tab>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <h1>BRIDGE</h1>

              <p></p>

              <p class="mb-0"></p>
              
                <v-card class="rounded-lg" v-if="selectedTokenName != null">
                  <v-row>
                    <v-col>
                      <center>
                      <img width="100px" height="100px" :src="selectedTokenImage" />
                      
                      </center>
                    </v-col>
                    <v-col>
                    <br><br>
                    {{selectedTokenName}}
                    </v-col>
                    <v-col class="b-5">
                      <br>
                      <v-text-field
                      class="mt-2"
                       
                        label="Amount"
                        hint="Please enter Decimal Value"
                        placeholder="Amount"
                        outlined
                        rounded
                     
                    
                     
                        clearable
                 
                       

                      ></v-text-field>

                    </v-col>
                    <v-col>
                      <br>
                      <center>
                      <v-btn dark class="mt-4  orange darken-1">Migrate !</v-btn>
                      </center>
                    </v-col>
                  </v-row>
                </v-card>
            <br><br>
              <v-row cols="12" lg="12" md="12">
                <div v-for="item in tokens" v-bind:key="item.key">
                  <v-col>
                    <br>
                    <v-btn text fab height="100px" width="100px"
                    @click="select(item.name , item.imgSrc)">
                    <img width="100px" height="100px" :src="item.imgSrc" />
                  </v-btn>
                  </v-col>
                </div>
              </v-row>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <h1>BRIDGE</h1>

              <p></p>

              <p class="mb-0"></p>
              
                <v-card v-if="selectedTokenName != null">
                  <v-row>
                    <v-col>
                      <center>
                      <img width="100px" height="100px" :src="selectedTokenImage" />
                      
                      </center>
                    </v-col>
                    <v-col>
                    <br><br>
                    {{selectedTokenName}}
                    </v-col>
                    <v-col class="b-5">
                      <br>
                      <v-text-field
                      class="mt-2"
                       
                        label="Amount"
                        hint="Please enter Decimal Value"
                        placeholder="Amount"
                        outlined
                        rounded           
                        clearable
                      ></v-text-field>
                    </v-col>
                    <v-col>
                      <br>
                      <center>
                      <v-btn class="mt-4 blue lighten-1">Migrate !</v-btn>
                      </center>
                    </v-col>
                  </v-row>
                </v-card>
            <br><br>
              <v-row cols="12" lg="12" md="12">
                <div v-for="item in tokens" v-bind:key="item.key">
                  <v-col>
                    <v-btn text fab height="100px" width="100px"
                    @click="select(item.name , item.imgSrc)">
                    <img width="100px" height="100px" :src="item.imgSrc" />
                  </v-btn>
                  </v-col>
                </div>
              </v-row>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs>
    </v-container>
  </div>
</template>

<script>
const { tokens } = require("../javascript/BridgeTokenTruth.js");
export default {
  name: "About",
  components: {},
  data() {
    return {
      tokens: null,
      selectedTokenName : null,
      selectedTokenImage : null,
    };
  },
  methods: {
    getAvailableTokens: async function() {
      //alert("Welcome Back : " + store.state.address + "!");
      this.tokens = tokens;
      // `event` is the native DOM event
    },
    select: function(name, image){
      this.selectedTokenImage = image;
      this.selectedTokenName = name;

    }
  },
  mounted: async function() {
    await this.getAvailableTokens();
  }
};
</script>
<style type="text/css"></style>
