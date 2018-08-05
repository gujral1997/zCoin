// zcoin ICO
pragma solidity ^0.4.11;

contract zCoin_ico {
    // introduced max number of zcoins
    uint public max_zcoins = 1000000;
    
    // introducing USD to zcoins conversion rate
    uint public usd_to_zcoins = 1000;
    
    // Introducing total number of zCoins that has been invested by the in 
    uint public total_zcoins_bought = 0;
    
    // Mapping from the investor address to ist equality in zcoin and USD
    mapping(address => uint) equity_zcoins;
    mapping(address => uint) equity_usd;

    // checking if investor can buy zCoins
    modifier can_buy_zcoins(uint usd_invested) {
        require (usd_invested * usd_to_zcoins + total_zcoins_bought <= max_zcoins);
        _;
    }
    
    // Getting the equality in zCoins of an investor
    function equiy_in_zcoins(address investor) external constant returns (uint) {
        return equity_zcoins[investor];
    }
    
    // Buying zCoins
    function buy_zcoins(address investor, uint usd_invested) external 
    can_buy_zcoins(usd_invested) {
        uint zcoins_bought = usd_invested * usd_to_zcoins;
        equity_zcoins[investor] += zcoins_bought;
        equity_usd[investor] = equity_zcoins[investor] / 1000;
        total_zcoins_bought += zcoins_bought;
        
    }
    
    // Selling zCoins
    function sell_zcoins(address investor, uint zcoins_sold) external {
        equity_zcoins[investor] -= zcoins_sold;
        equity_usd[investor] = equity_zcoins[investor] / 1000;
        total_zcoins_bought -= zcoins_sold;
        
    }
}
