var fs = require("fs");
var request = require("request");
const fetch = require("node-fetch");
var download = function(uri, filename) {
  request.head(uri, function(err, res, body) {
    console.log("content-type:", res.headers["content-type"]);
    console.log("content-length:", res.headers["content-length"]);

    if (res.headers["content-length"] != 36) {
      request(uri).pipe(fs.createWriteStream(filename));
    }
  });
};
var blocknumber;
var getblocknumber = async function() {
  var myHeaders = new fetch.Headers();
  myHeaders.append("Content-Type", "application/json");

  var raw = JSON.stringify({
    jsonrpc: "2.0",
    id: 1,
    method: "hmyv2_blockNumber",
    params: []
  });

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
    redirect: "follow"
  };

  await fetch("https://rpc.s0.t.hmny.io", requestOptions)
    .then(response => response.text())
    .then(results => {
      results = JSON.parse(results);
      blocknumber = results.result;
      console.log(blocknumber);
    })
    .catch(error => console.log("error", error));
};

var getvalidator = async function() {
  var myHeaders = new fetch.Headers();
  myHeaders.append("Content-Type", "application/json");

  var raw = JSON.stringify({
    jsonrpc: "2.0",
    id: 1,
    method: "hmyv2_getAllValidatorInformationByBlockNumber",
    params: [-1, 8502132 - 1]
  });

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
    redirect: "follow"
  };

  fetch("https://rpc.s0.t.hmny.io", requestOptions)
    .then(response => response.text())
    .then(result => {
      const results = JSON.parse(result);
      var i = 0;

      while (i < results.result.length) {
        if (results.result[i]["active-status"] != "inactive") {
          var valAddr = results.result[i].validator.address;
          download(
            "https://api.stake.hmny.io/networks/mainnet/validators/" +
              valAddr +
              "/avatar",
            valAddr + ".png"
          );
        }
        i++;
      }
    })
    .catch(error => console.log("error", error));
};
//getblocknumber()
getvalidator();
