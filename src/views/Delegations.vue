<template>
  <div class="Delegations">
    <v-container>
      <h3>My Delegations :</h3>
      <br />
      <mydelegations />
    </v-container>
  </div>
</template>

<script>
import mydelegations from "../components/delegations/mydelegations.vue";
export default {
  name: "Stake",
  components: {
    mydelegations
  }
};
</script>
<style type="text/css"></style>
