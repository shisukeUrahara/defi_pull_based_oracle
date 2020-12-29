const coinGecko = require('coingecko-api');
const Oracle = artifacts.require('Oracle.sol');

// fetch data after each interval (ms)
const POLL_INTERVAL= 5000;
const coinGeckoClient = new coinGecko();


module.exports= async (done)=>{
    const [_,reporter]= await web3.eth.getAccounts();

    const oracle= await Oracle.deployed();

    while(true){

        const response = await coinGeckoClient.coins.fetch('bitcoin',{});
        // console.log("**@ response is , ",response);

        let currentPrice= parseFloat(response.data.market_data.current_price.usd);
        currentPrice= parseInt(currentPrice*100);

        await  oracle.updateData(
            web3.utils.sha3('BTC/USD'),
            currentPrice,
            {from:reporter}
        );

        console.log("**@ new price updated for BTC/USD on chain , new price is , ",currentPrice);

        // sit for next iteration after poll interval
        await new Promise((resolve,reject)=> setTimeout(resolve,POLL_INTERVAL));


    }

    done ();
}

