<template>
  <div class="Validators">
    <v-container>
      <h3>Validators</h3>

      <center><allvalidators /></center>
    </v-container>
  </div>
</template>

<script>
import allvalidators from "../components/validators/allvalidators.vue";
export default {
  name: "Validators",
  components: {
    allvalidators
  }
};
</script>
<style type="text/css"></style>
