pragma solidity ^0.7.3;

import './IOracle.sol';

contract Consumer {
    IOracle public oracle ;

    constructor (address _oracle) public {
     oracle = IOracle(_oracle);
    }

    // a function to fetch data from the oracle data 
    function getData() public {
        bytes32 key= keccak256(abi.encodePacked('BTC/USD'));

        // fetch data from the oracle 
        (bool result , uint timestamp , uint payload )= oracle.getData(key);

        // check that we get the result
        require(result==true,'Price not found');
        require(timestamp >= block.timestamp-2 minutes , 'Price too old');
        // do something with data
    }
}