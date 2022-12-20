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
}