<template>
  <div class="sidebar">
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading"></div>
      <div class="list-group list-group-flush">
        <a
          ><router-link
            to="/"
            class="list-group-item list-group-item-action bg-light"
            >Dashboard</router-link
          ></a
        >
        <a
          ><router-link
            to="/Card"
            class="list-group-item list-group-item-action bg-light"
            >Card</router-link
          ></a
        >
        <a
          ><router-link
            to="/Merchant"
            class="list-group-item list-group-item-action bg-light"
            >Merchant</router-link
          ></a
        >

        <a
          ><router-link
            to="/Swap"
            class="list-group-item list-group-item-action bg-light"
            >Swap</router-link
          ></a
        >
        <a
          ><router-link
            to="/Pool"
            class="list-group-item list-group-item-action bg-light"
            >Pool</router-link
          ></a
        >
        <a
          ><router-link
            to="/Stake"
            class="list-group-item list-group-item-action bg-light"
            >Stake</router-link
          ></a
        >
        <a
          ><router-link
            to="/Preferences"
            class="list-group-item list-group-item-action bg-light"
            >Preferences</router-link
          ></a
        >
        <a
          ><router-link
            to="/Statistics"
            class="list-group-item list-group-item-action bg-light"
            >Statistics</router-link
          ></a
        >
        <a
          ><router-link
            to="/About"
            class="list-group-item list-group-item-action bg-light"
            >About</router-link
          ></a
        >
      </div>
    </div>
  </div>
  <!-- Page Content -->
</template>

<script>
export default {
  name: "sidebar",
  props: {
    msg: String
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#wrapper {
  overflow-x: hidden;
}

#sidebar-wrapper {
  min-height: 100vh;

  -webkit-transition: margin 0.25s ease-out;
  -moz-transition: margin 0.25s ease-out;
  -o-transition: margin 0.25s ease-out;
  transition: margin 0.25s ease-out;
  position: fixed;
  z-index: 99;
}

#sidebar-wrapper .sidebar-heading {
  padding: 0.875rem 1.25rem;
  padding-bottom: 50px;
  font-size: 2rem;
}

#sidebar-wrapper .list-group {
  width: 15rem;
}

#page-content-wrapper {
  min-width: 100vw;
}

#wrapper.toggled #sidebar-wrapper {
  margin-left: 0;
}

@media (min-width: 768px) {
  #sidebar-wrapper {
    margin-left: 0;
  }

  #page-content-wrapper {
    min-width: 0;
    width: 100%;
  }

  #wrapper.toggled #sidebar-wrapper {
    margin-left: -15rem;
  }
}
</style>
