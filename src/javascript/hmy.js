const { Harmony } = require("@harmony-js/core");
const { ChainType } = require("@harmony-js/utils");

export default new Harmony(
  // let's assume we deploy smart contract to this end-point URL
  "https://api.s0.t.hmny.io",
  {
    chainType: ChainType.Harmony,
    chainId: 1
  }
);
