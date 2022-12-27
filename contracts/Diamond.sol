//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibDiamond } from "./libraries/LibDiamond.sol";
import { IDiamondCut } from "./interfaces/IDiamondCut.sol";

contract Diamond {
    
    constructor(address _ownerOfContract, address _diamondCutFacet) payable {
        LibDiamond.setContractOwner(_ownerOfContract);

        // Add external diamondCut function from diamondCutFaucet
        IDiamondCut.FaucetCut[] memory cut = new IDiamondCut.FaucetCut[](1);
        bytes[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IDiamondCut.diamondCut.selector;
        cut[0] = IDiamondCut.FaucetCut({
            facetAddress: _diamondCutFacet,
            action: IDiamondCut.FaucetCutAction.Add,
            functionSelectors: functionSelectors
        });
        LibDiamond.diamondCut(cut, address(0), "");
    }

    fallback() external payable {
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get the diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        address facet = ds.selectorToFacetAndPosition[msg.sig].facetAddress;
        require(facet != address(0), "Diamond: Function does not exist");
        // execute external function from facet using delegatecall and return any value.
        
    }
}