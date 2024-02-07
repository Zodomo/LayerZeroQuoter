// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.23;

import {OApp, Origin, MessagingFee} from "../lib/LayerZero-v2/oapp/contracts/oapp/OApp.sol";

contract LayerZeroQuoter is OApp {
    constructor(address _endpoint, address _delegate) OApp(_endpoint, _delegate) {}

    function quote(uint32 dstEid, bytes memory message, bytes memory options, bool payInLzToken)
        external
        view
        returns (uint256 nativeFee, uint256 lzTokenFee)
    {
        MessagingFee memory fee = _quote(dstEid, message, options, payInLzToken);
        return (fee.nativeFee, fee.lzTokenFee);
    }

    function _lzReceive(
        Origin calldata origin,
        bytes32 guid,
        bytes calldata message,
        address executor,
        bytes calldata extraData
    ) internal override {}
}
