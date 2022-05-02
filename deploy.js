const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const { abi, evm } = require('./compile');
const { mnemonicKeys, networkURL } = require('./config/config');
console.log(mnemonicKeys, networkURL);
const INITIAL_STRING = 'There is a new message';

const provider = new HDWalletProvider(mnemonicKeys, networkURL);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0]);

  const result = await new web3.eth.Contract(abi)
    .deploy({ data: evm.bytecode.object })
    .send({ gas: '1000000', from: accounts[0] });

  console.log(abi);
  console.log('Contract deployed to', result.options.address);
  provider.engine.stop();
};
deploy();
