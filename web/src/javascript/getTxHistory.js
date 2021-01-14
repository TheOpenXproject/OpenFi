class getTxHistory {
  constructor() {
    this.Txhistory = null;
    this.isloading = null;
  }

  async getHistory(walletAddr) {
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify({
      jsonrpc: "2.0",
      id: 1,
      method: "hmyv2_getTransactionsHistory",
      params: [
        {
          address: walletAddr,
          pageIndex: 0,
          pageSize: 1,
          fullTx: true,
          txType: "ALL",
          order: "ASC"
        }
      ]
    });

    var requestOptions = {
      method: "POST",
      headers: myHeaders,
      body: raw,
      redirect: "follow"
    };
    let jsondata;
    fetch("https://rpc.s0.t.hmny.io", requestOptions)
      .then(response => response.text())
      .then(function(json) {
        jsondata = json;
      })
      .catch(error => console.log("error", error));
    console.log(jsondata);
    return jsondata;
  }
}

export default getTxHistory;
