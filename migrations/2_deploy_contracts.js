const Oracle = artifacts.require("Oracle.sol");
const Consumer= artifacts.require('Consumer.sol');


module.exports = async  function (deployer,_network,accounts) {
    const [admin,reporter,_]= accounts;
    // deploying oracle
    await  deployer.deploy(Oracle,admin);

   // getting oracle instance and setting reporter access
    const oracle= await Oracle.deployed();
    await oracle.updateReporter(reporter,true);

    // deploy the consumer contract
    await deployer.deploy(Consumer,oracle.address);
};
