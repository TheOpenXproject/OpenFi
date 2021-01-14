<template>
  <div class="balances ">
    <table width="250px" class="ml-5">
      <tr>
        <td class="text-left">
          One:
        </td>
        <td>
          {{ one }}
        </td>
      </tr>
      <tr>
        <td class="text-left">
          Wone:
        </td>
        <td>
          {{ ones }}
        </td>
      </tr>
      <tr>
        <td class="text-left">
          Busd :
        </td>
        <td>
          {{ busd }}
        </td>
      </tr>
      <tr>
        <td class="text-left">
          Link :
        </td>
        <td>
          {{ link }}
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import store from "../store";
import hmy from "../javascript/hmy";

const { Units, numToStr, fromWei } = require("@harmony-js/utils");
const { BN } = require("@harmony-js/crypto");
export default {
  name: "balances",
  props: {
    msg: String
  },

  methods: {
    getOneBalance: async function() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "hmyv2_getBalance",
        params: [store.state.address]
      });

      var requestOptions = {
        method: "POST",
        headers: myHeaders,
        body: raw,
        redirect: "follow"
      };

      fetch("https://api.s0.b.hmny.io", requestOptions)
        .then(response => response.text())
        .then(result => {
          result = JSON.parse(result);

          const num = result;
          const str = numToStr(num);
          console.log(str);
          // fromWei
          const Wei = new BN(str);
          const expected = fromWei(Wei, Units.one);
          console.log(expected);

          this.one = expected;
          store.commit("setOneBal", expected);
          this.getWoneBalance();
          this.getBusdBalance();
          this.getLinkBalance();
        })
        .catch(error => console.log("error", error));
    },
    getWoneBalance: async function() {
      const wallet = store.state.wallet;
      const onesAddr = "0xd76a792c2fdd4cd0deafa959263c80d631621991";
      let options = {
        gasPrice: 1000000000,
        gasLimit: 500000
      };
      const unattachedContract = await this.initializeContract(onesAddr);
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .balanceOf(store.state.address)
        .call(options);
      const num = value;
      const str = numToStr(num);
      console.log(str);
      // fromWei
      const Wei = new BN(str);
      const expected = fromWei(Wei, Units.one);
      console.log(expected);

      this.ones = expected;
      store.commit("setWoneBal", expected);
      console.log(store.state.wonebal);
      return expected;
    },
    getBusdBalance: async function() {
      const wallet = store.state.wallet;
      const onesAddr = "0xE176EBE47d621b984a73036B9DA5d834411ef734";
      let options = {
        gasPrice: 1000000000,
        gasLimit: 500000
      };
      const unattachedContract = await this.initializeContract(onesAddr);
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .balanceOf(store.state.address)
        .call(options);
      const num = value;
      const str = numToStr(num);
      console.log(str);
      // fromWei
      const Wei = new BN(str);
      const expected = fromWei(Wei, Units.one);
      console.log(expected);

      this.busd = expected;
      store.commit("setBusdBal", expected);
    },
    getLinkBalance: async function() {
      const wallet = store.state.wallet;
      const woneAddr = "0x218532a12a389a4a92fC0C5Fb22901D1c19198aA";
      let options = {
        gasPrice: 1000000000,
        gasLimit: 500000
      };
      const unattachedContract = await this.initializeContract(onesAddr);
      const contract = wallet.attachToContract(unattachedContract);
      const value = await contract.methods
        .balanceOf(store.state.address)
        .call(options);
      const num = value;
      const str = numToStr(num);
      console.log(str);
      // fromWei
      const Wei = new BN(str);
      const expected = fromWei(Wei, Units.one);
      console.log(expected);

      this.link = expected;
      store.commit("setLinkBal", expected);
      return expected;
    },
    initializeContract: async function(HRCtoken) {
      const abi = [
        // balanceOf
        {
          constant: true,
          inputs: [{ name: "_owner", type: "address" }],
          name: "balanceOf",
          outputs: [{ name: "balance", type: "uint256" }],
          type: "function"
        },
        // decimals
        {
          constant: true,
          inputs: [],
          name: "decimals",
          outputs: [{ name: "", type: "uint8" }],
          type: "function"
        }
      ];
      const contractAddress = HRCtoken;
      const contractInstance = hmy.contracts.createContract(
        abi,
        contractAddress
      );
      return contractInstance;
    }
  },
  data() {
    return {
      eventTableData: [],
      one: 0,
      ones: 0,
      busd: 0,
      link: 0
    };
  },
  mounted: async function() {
    this.getOneBalance();
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.truncate {
  max-width: 1px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
