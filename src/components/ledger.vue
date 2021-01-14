<template>
  <div class="harmonyLedger">
    <input id="webusb" v-model="transportChoice" type="radio" value="WebUSB" />
    <label for="webusb">WebUSB</label>
    <input id="u2f" v-model="transportChoice" type="radio" value="U2F" />
    <label for="u2f">U2F</label>
    <br />
    <!--
        Commands
    -->
    <button @click="getVersion">
      Get Version
    </button>

    <button @click="showAddress">
      Show Address
    </button>

    <button @click="signTx">
      Sign Example TX
    </button>

    <button @click="signStake">
      Sign Example CreateValidator
    </button>

    <button @click="signDelegate">
      Sign Example Delegate
    </button>
    <!--
        Commands
    -->
    <ul id="ledger-status">
      <li v-for="item in ledgerStatus" :key="item.index">
        {{ item.msg }}
      </li>
    </ul>
  </div>
</template>

<script>
/* eslint-disable */
// eslint-disable-next-line import/no-extraneous-dependencies
import TransportWebUSB from '@ledgerhq/hw-transport-webusb';
// eslint-disable-next-line import/no-extraneous-dependencies
import TransportU2F from '@ledgerhq/hw-transport-u2f';
import HarmonyApp from '../javascript/ledger.js';
const { Harmony } = require('@harmony-js/core');
const {
    StakingTransaction,
    CreateValidator,
    Delegate,
    Description,
    CommissionRate,
    Decimal,
    Directive,
} = require('@harmony-js/staking');
// import or require settings
const { ChainID, ChainType } = require('@harmony-js/utils');
const URL_TESTNET = 'https://api.s0.b.hmny.io';
// const URL_DEVNET = 'https://api.s0.pga.hmny.io';
// const URL_MAINNET = 'https://api.s0.t.hmny.io';
const harmony = new Harmony(
    // rpc url
    URL_TESTNET,
    {
        // chainType set to Harmony
        chainType: ChainType.Harmony,
        // chainType set to HmyLocal
        chainId: ChainID.HmyTestnet,
        // chainId: ChainID.HmyPangaea,
    },
);
export default {
    name: 'HarmonyLedger',
    props: {
    },
    data() {
        return {
            deviceLog: [],
            transportChoice: 'WebUSB',
        };
    },
    computed: {
        ledgerStatus() {
            return this.deviceLog;
        },
    },
    methods: {
        log(msg) {
            this.deviceLog.push({
                index: this.deviceLog.length,
                msg,
            });
        },
        async getTransport() {
            let transport = null;
            this.log(`Trying to connect via ${this.transportChoice}...`);
            if (this.transportChoice === 'WebUSB') {
                try {
                    transport = await TransportWebUSB.create();
                } catch (e) {
                    this.log(e);
                }
            }
            if (this.transportChoice === 'U2F') {
                try {
                    transport = await TransportU2F.create(10000);
                } catch (e) {
                    this.log(e);
                }
            }
            return transport;
        },
        async getVersion() {
            this.deviceLog = [];
            // Given a transport (U2F/HIF/WebUSB) it is possible instantiate the app
            const transport = await this.getTransport();
            const app = new HarmonyApp(transport);
            // now it is possible to access all commands in the app
            const response = await app.getVersion();
            if (response.return_code !== 0x9000) {
                this.log(`Error [${response.return_code}] ${response.error_message}`);
                return;
            }
            this.log('Response received!');
            this.log(`App Version ${response.major}.${response.minor}.${response.patch}`);
            this.log('Full response:');
            this.log(response);
        },
        async showAddress() {
            this.deviceLog = [];
            // Given a transport (U2F/HIF/WebUSB) it is possible instantiate the app
            const transport = await this.getTransport();
            const app = new HarmonyApp(transport);
            // now it is possible to access all commands in the app
            const response = await app.publicKey(false);
            if (response.return_code !== 0x9000) {
                this.log(`Error [${response.return_code}] ${response.error_message}`);
                return;
            }
            const address = response.one_address.toString();
            this.log('Harmony one address for ledger is:');
            this.log(address);
        },
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
        },
        async signStake() {
            this.deviceLog = [];
            const transport = await this.getTransport();
            const app = new HarmonyApp(transport);
            const shardStructure = await harmony.blockchain.getShardingStructure();
            harmony.shardingStructures(shardStructure.result);
            const desc = new Description(
                'Alice',
                'alice',
                'alice.harmony.one',
                'Bob',
                "Don't mess with me!!!",
            );
            const validatorAddress = 'one1a0x3d6xpmr6f8wsyaxd9v36pytvp48zckswvv9';
            const commissionRates = new CommissionRate(
                new Decimal('0.1'),
                new Decimal('0.9'),
                new Decimal('0.05'),
            );
            const createMsg = new CreateValidator(
                validatorAddress,
                desc,
                commissionRates,
                '0xa',
                '0x0bb8',
                [
                    '0xb9486167ab9087ab818dc4ce026edb5bf216863364c32e42df2af03c5ced1ad181e7d12f0e6dd5307a73b62247608611',
                ],
                '0x64',
            );
            const shardId = 0;
            const stakingTxn = new StakingTransaction(
                Directive.DirectiveCreateValidator,
                createMsg,
                '0x2',
                '0x10',
                'numberToHex(“510000”)',
                '0x2',
                '0x2',
                '',
                '',
            );
            const signedStakingTxn = await app.signStakingTransaction(stakingTxn, harmony.chainId,
                shardId, harmony.messenger);
            console.log(signedStakingTxn);
            signedStakingTxn.observed()
                .on('transactionHash', (txnHash) => {
                    console.log('');
                    console.log('--- hash ---');
                    console.log('');
                    console.log(txnHash);
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
                    console.log('');
                });
            signedStakingTxn.setMessenger(harmony.messenger);
            const [sentTxn, txnHash] = await signedStakingTxn.sendTransaction();
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
        },
        async signDelegate() {
            this.deviceLog = [];
            const transport = await this.getTransport();
            const app = new HarmonyApp(transport);
            const shardStructure = await harmony.blockchain.getShardingStructure();
            harmony.shardingStructures(shardStructure.result);
            const delegateMsg = new Delegate(
                'one1q6gkzcap0uruuu8r6sldxuu47pd4ww9w9t7tg6', // from delegate command.
                'one1pdv9lrdwl0rg5vglh4xtyrv3wjk3wsqket7zxy', // fd416cb87dcf8ed187e85545d7734a192fc8e976f5b540e9e21e896ec2bc25c3
                '0xde0b6b3a7640000', // 0x56BC75E2D63100000
            );
            const stakingTxn = new StakingTransaction(
                '0x2',
                delegateMsg,
                '0x2',
                '0x10',
                '0x0927c0',
                harmony.chainId,
                2,
                '',
                '',
            );
            const shardId = 0;
            const signedStakingTxn = await app.signStakingTransaction(stakingTxn, harmony.chainId,
                    shardId, harmony.messenger);
            console.log(signedStakingTxn);
            signedStakingTxn.observed()
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
                    console.log('');
                });
            signedStakingTxn.setMessenger(harmony.messenger);
            const [sentTxn, txnHash] = await signedStakingTxn.sendTransaction();
            console.log(sentTxn);
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
        },
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    h3 {
        margin: 40px 0 0;
    }
    button {
        padding: 5px;
        font-weight: bold;
        font-size: medium;
    }
    ul {
        padding: 10px;
        text-align: left;
        alignment: left;
        list-style-type: none;
        background: black;
        font-weight: bold;
        color: greenyellow;
    }
</style>