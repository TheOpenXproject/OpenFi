import HarmonyApp from "../javascript/ledger.js";
import TransportWebUSB from "@ledgerhq/hw-transport-webusb";
//const { harmony } = require('@harmony-js/core');

class Ledgerwallet {
  constructor() {
    this.ledgerwallet;
  }

  async signin() {
    this.deviceLog = [];
    // Given a transport (U2F/HIF/WebUSB) it is possible instantiate the app
    const transport = await this.getTransport();
    const app = new HarmonyApp(transport);
    // now it is possible to access all commands in the app
    const response = await app.publicKey(true);
    if (response.return_code !== 0x9000) {
      this.log(`Error [${response.return_code}] ${response.error_message}`);
      return;
    }

    this.address = response.one_address.toString();
    this.isAuthorized = true;
  }

  attachToContract(contract) {
    contract.wallet.signTransaction = async txn => {
      console.log(this.address);
      txn.from = this.address;
      const transport = await this.getTransport();
      const app = new HarmonyApp(transport);
      const signTx = await app
        .signTx(txn)
        .catch(err => console.error("Signing Error" + err));
      const signTxx = await app
        .signTransaction(signTx, 1, 0, transport)
        .catch(err => console.error("Signing Error" + err));
      console.log("x" + signTx);
      console.log("xx" + signTxx);
      return signTx;
    };

    return contract;
  }
  /*
async signTx() {
            this.deviceLog = [];
            // Given a transport (U2F/HIF/WebUSB) it is possible instantiate the app
            const transport = await this.getTransport();
            const app = new HarmonyApp(transport);
            const txn = harmony.transactions.newTx({
                //  token send to
                to: 'one1sl6hku7wxgxnhajrc0a96p6zpea6qr0p0sqajk',
                nonce: 0,
                // amount to send
                value: '100000000000000000',
                // gas limit, you can use string
                gasLimit: '210000',
                shardID: shardId,
                toShardID: 0,
                gasPrice: new harmony.utils.Unit('100').asGwei().toWei(),
            });
            const shardId = 0;
            const signedTxn = await app.signTransaction(txn,
                harmony.chainId, shardId, harmony.messenger);
            // Frontend received back the signedTxn and do the followings to Send transaction.
            signedTxn.observed()
                .on('transactionHash', (txnHash) => {
                    console.log('');
                    console.log('--- hash ---');
                    console.log('');
                    console.log(txnHash);
                    this.log('txHash = ');
                    this.log(txnHash.toString());
                    console.log('');
                })
                .on('receipt', (receipt) => {
                    console.log('');
                    console.log('--- receipt ---');
                    console.log('');
                    console.log(receipt);
                    console.log('');
                })
                .on('cxReceipt', (receipt) => {
                    console.log('');
                    console.log('--- cxReceipt ---');
                    console.log('');
                    console.log(receipt);
                    console.log('');
                })
                .on('error', (error) => {
                    console.log('');
                    console.log('--- error ---');
                    console.log('');
                    console.log(error);
                    this.log('error = ', error.toString());
                    console.log('');
                });
            // send the txn, get [Transaction, transactionHash] as result
            const [sentTxn, txnHash] = await signedTxn.sendTransaction();
            // to confirm the result if it is already there
            const confiremdTxn = await sentTxn.confirm(txnHash);
            // if the transactino is cross-shard transaction
            if (!confiremdTxn.isCrossShard()) {
                if (confiremdTxn.isConfirmed()) {
                    console.log('--- Result ---');
                    console.log('');
                    console.log('Normal transaction');
                    console.log(`${txnHash} is confirmed`);
                    console.log('');
                    process.exit();
                }
            }
            if (confiremdTxn.isConfirmed() && confiremdTxn.isCxConfirmed()) {
                console.log('--- Result ---');
                console.log('');
                console.log('Cross-Shard transaction');
                console.log(`${txnHash} is confirmed`);
                console.log('');
                process.exit();
            }
        }
*/
  async getTransport() {
    let transport = null;

    try {
      transport = await TransportWebUSB.create();
    } catch (e) {
      this.log(e);
    }

    return transport;
  }
}

export default Ledgerwallet;
