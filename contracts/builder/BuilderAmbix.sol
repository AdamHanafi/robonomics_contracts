//
// AIRA Builder for Ambix contract
//
// Ethereum address:
//  - Mainnet:
//  - Testnet: 
//

pragma solidity ^0.4.4;
import 'creator/CreatorAmbix.sol';
import './Builder.sol';

/**
 * @title BuilderAmbix contract
 */
contract BuilderAmbix is Builder {
    /**
     * @dev Run script creation contract
     * @param _client is a contract destination address (zero for sender)
     * @return address new contract
     */
    function create(address _client) payable returns (address) {
        if (buildingCostWei > 0 && beneficiary != 0) {
            // Too low value
            if (msg.value < buildingCostWei) throw;
            // Beneficiary send
            if (!beneficiary.send(buildingCostWei)) throw;
            // Refund
            if (msg.value > buildingCostWei) {
                if (!msg.sender.send(msg.value - buildingCostWei)) throw;
            }
        } else {
            // Refund all
            if (msg.value > 0) {
                if (!msg.sender.send(msg.value)) throw;
            }
        }

        if (_client == 0)
            _client = msg.sender;
 
        var inst = CreatorAmbix.create();
        getContractsOf[_client].push(inst);
        Builded(_client, inst);
        inst.delegate(_client);
        return inst;
    }
}
