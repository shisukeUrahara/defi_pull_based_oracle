pragma solidity ^0.7.3;

contract Oracle {
    // struct to hold the data
    struct Data{
        uint date ;
        uint payload;
    }
    // admin for this contract
    address public admin;
    // mapping to check if address is allowed to report data to the contract
    mapping(address=> bool) public  reporters;
    // mapping to store reported data
    mapping(bytes32 => Data) public data;

    constructor(address _admin){
     admin= _admin;
    }

    // function to add or revoke access for an address as a reporter
    function updateReporter(address _reporter, bool isReporter) external {
        require(msg.sender==admin,'Admin required');
        reporters[_reporter]=isReporter;
    }

    // function to update oracle data  by reporters
    function updateData(bytes32 key,uint payload) external {
        // check that reporter is allowed to report data
        require(reporters[msg.sender]==true,'Only Reporter');
        data[key]= Data(block.timestamp,payload);
    }

    // a function to get data by consumers
    function getData (bytes32 key) external view
    returns (
        bool result,
        uint date ,
        uint payload
    ) 
    {
        if(data[key].date==0){
            return (false , 0 , 0);
        }
        else {
            return (true,data[key].date,data[key].data);
        }

    } 
}