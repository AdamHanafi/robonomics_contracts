pragma solidity ^0.4.2;

import 'cashflow/ShareSale.sol';

library CreatorShareSale {
    function create(address _target, address _etherFund, address _shares, uint256 _price_wei) returns (ShareSale)
    { return new ShareSale(_target, _etherFund, _shares, _price_wei); }

    function version() constant returns (string)
    { return "v0.5.0 (041be4cf)"; }

    function abi() constant returns (string)
    { return '[{"constant":true,"inputs":[],"name":"shares","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"closed","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_owner","type":"address"}],"name":"delegate","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"etherFund","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_price_wei","type":"uint256"}],"name":"setPrice","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"priceWei","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"target","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"inputs":[{"name":"_target","type":"address"},{"name":"_etherFund","type":"address"},{"name":"_shares","type":"address"},{"name":"_price_wei","type":"uint256"}],"type":"constructor"},{"payable":false,"type":"fallback"}]'; }
}
