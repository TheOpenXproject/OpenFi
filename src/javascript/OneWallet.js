

class Onewallet {
  constructor() {
    this.isOneWallet = window.onewallet && window.onewallet.isOneWallet;
    this.onewallet = window.onewallet;
  }

  async signin() {
    const getAccount = await this.onewallet.getAccount();
    this.address = getAccount.address;
    this.isAuthorized = true;
  }
  signTransaction(txn) {
    if (this.isOneWallet) {
      return this.onewallet.signTransaction(txn);
    }
  }

  async signStakingTxn(txn){

  txn.from = this.address

  const signedTxn = await this.signTransaction(txn); //or you can call window.onewallet.signTransaction(txn) directly
  const [sentTxn, txnHash] = await signedTxn.sendTransaction();
  return [sentTxn, txnHash]
  }

  attachToContract(contract) {
    if (this.onewallet) {
      contract.wallet.signTransaction = async tx => {
        tx.from = this.address;
        console.log(this.address);
        console.log("tx = " + tx);
        const signTx = await this.signTransaction(tx);
        console.log(signTx);
        return signTx;
      };
    }
    return contract;
  }
}

export default Onewallet;
