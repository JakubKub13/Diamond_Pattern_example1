//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This functions look at diamonds
interface IDiamondLoupe {
    //This functions  should be called frequently by tools

    struct Facet {
        address facetAddress;
        bytes4[] functionSelectors;
    }

    // Gets all facet addresses and their four byte function selectors
    function facets() external view returns (Facet[] memory facets_);

    // Gets all function selectors supported by specific facet
    function facetFunctionSelectors(address _facet) external view returns (bytes4[] memory facetFunctionSelectors_);

    // Get all the facet addresses used by a diamond
    function facetAddresses() external view returns (address[] memory facetAddresses_);

    // Gets the facet that supports the given selector
    function facetAddress(bytes4 _functionSelector) external view returns (address facetAddress_);
}