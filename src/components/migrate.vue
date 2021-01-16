<template>
  <div class="migrate">
  	 
  	<template>
  	  <v-row justify="space-around">
  	    <v-col cols="auto">
  	      <v-dialog
  	        transition="dialog-bottom-transition"
  	        max-width="1000"
  	      >
        <template v-slot:activator="{ on, attrs }">

        	
           <v-btn dark  class="orange darken-2
           center pl-15 pr-15" width="100%" v-bind="attrs"
           v-on="on" center>

           <table>
           	<tr>

           		<td>Migrate with </td>
           		           		<td>	<v-img
           	class="ml-8"
            lazy-src="../assets/metamask.png"
            max-height="25"
            max-width="25"
            src="../assets/metamask.png"
          ></v-img></td>
          <br>
           	
           </tr></table>
            </v-btn>
          

        </template>
        
  	        <template v-slot:default="dialog">
  	          <v-card height="100%" width="">
  	            <v-toolbar
  	            height="40px"
  	              color="orange darken-2"
  	              dark
  	              small
  	            ><v-img
            contain
            lazy-src="../assets/metamask.png"
            max-height="25"
            max-width="25"
            src="../assets/metamask.png"
          ></v-img><span class="pl-5">Ethereum to Harmony bridge</span></v-toolbar>
  	            <v-card-text class="mt-5">
  	              <template>
  	                <v-stepper v-model="e1">
  	                  <v-stepper-header>
  	                    <v-stepper-step
  	                      :complete="e1 > 1"
  	                      step="1"
  	                    >
  	                      Create Harmony Wallet
  	                    </v-stepper-step>

  	                    <v-divider></v-divider>

  	                    <v-stepper-step
  	                      :complete="e1 > 2"
  	                      step="2"
  	                    >
  	                      Migrate to harmony Chain
  	                    </v-stepper-step>

  	                    <v-divider></v-divider>

  	                    <v-stepper-step step="3">
  	                     Create an account or login.
  	                    </v-stepper-step>
  	                  </v-stepper-header>

  	                  <v-stepper-items>
  	                    <v-stepper-content step="1">
  	                      <v-card
  	                      flat
  	                        class="mb-2"
  	                        color="white lighten-1"
  	                        height="auto"
  	                      >
  	                      <center>

  	                      	<table>
  	                      		<tr class="">Please Get Yourself the Harmony One Wallet Extention for Chrome</tr>
  	                      		<tr><img height="200px" src="../assets/chromeappstore.png"></tr>
  	                      		<tr class="center"><b>or</b></tr>
  	                      		<tr>Use Ledger Nano S (Recomended) with a ONE Harmony address installed from LedgerLive</tr>
  	                      		<tr><img class="center" src="../assets/ledgerapp.png"></tr>
  	                      	</table>
  	                      	  
  	                      </center>
  	                      	
  	                      </v-card>
  	                      <v-btn @click="dialog.value=false" text>
  	                        cancel
  	                      </v-btn>

  	                      <v-btn
  	                      class="float-right"
  	                        color="success"
  	                        @click="e1++"
  	                      >
  	                        Continue
  	                      </v-btn>
  	                    </v-stepper-content>

  	                    <v-stepper-content id="bridge" step="2">
  	                      <v-card
  	                      	flat
  	                        class=""
  	                        color="white"
  	                        
  	                        height="auto"
  	                      > <center><img class="" center height="auto" src="../assets/bridge.png"></center></v-card>




  	                      <v-btn @click="e1--" text>
  	                        Back
  	                      </v-btn>

  	                      <v-btn
  	                      class="float-right"
  	                        color="success"
  	                        @click="e1++"
  	                      >
  	                        Continue
  	                      </v-btn>
  	                    </v-stepper-content>

  	                    <v-stepper-content step="3">
  	                      <v-card
  	                        class="mb-12"
  	                        color="green lighten-1"
  	                        height="auto"
  	                        dark
  	                      ><center>
  	                      	Now you're all set to start deploying your smart contracts to use OpenFi. <br>
  	                      	click on continue to continue (lol)
  	                      	</center>
  	                      </v-card>
  	                      <v-btn @click="e1--" text>
  	                        Back
  	                      </v-btn>

  	                      <v-btn
  	                      class="float-right"
  	                        color="success"
  	                        @click="dialog.value=false"
  	                      >
  	                        Done
  	                      </v-btn>
  	                    </v-stepper-content>
  	                  </v-stepper-items>
  	                </v-stepper>
  	              </template>
  	            </v-card-text>
  	            <v-card-actions class="justify-end">

  	            </v-card-actions>
  	          </v-card>
  	        </template>
  	      </v-dialog>
  	    </v-col>


  	  </v-row>
  	</template>




  </div>
</template>

<script>




export default {
  name: "migrate",
  props: {
    msg: String
  },
  components: {
},
  data() {
    return {
      e1: 1
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.bridge{
	overflow: hidden;
}
/style>
