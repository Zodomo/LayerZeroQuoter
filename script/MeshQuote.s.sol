// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.23;

import {Script, console2} from "forge-std/Script.sol";
import {LZConfig} from "../src/LZConfig.sol";
import {LayerZeroQuoter} from "../src/LayerZeroQuoter.sol";
import {LibClone} from "../lib/solady/src/utils/LibClone.sol";
import {LibString} from "../lib/solady/src/utils/LibString.sol";
import {OptionsBuilder} from "../lib/LayerZero-v2/oapp/contracts/oapp/libs/OptionsBuilder.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract MeshQuoteScript is Script, LZConfig {
    using LibString for string;
    using LibString for uint256;
    using LibString for address;
    using OptionsBuilder for bytes;
    using EnumerableSet for EnumerableSet.UintSet;

    ///////////// CONFIGURE SCRIPT PARAMS HERE /////////////

    uint128 internal gas = 50_000; // Must be in units of gas, not in gwei
    uint128 internal msgValue = 0.01 ether;
    bytes internal message = abi.encode("Zodomo");
    bool internal payInLzToken = false;

    ////////////////////////////////////////////////////////

    error InvalidEid();
    error EidConfigured();

    struct Deployment {
        string chain;
        address addr;
        uint256 forkId;
    }

    EnumerableSet.UintSet internal eids;
    mapping(uint256 eid => Deployment) internal deployments;

    function _addressToBytes32(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    function _weiToEtherString(uint256 weiAmount) internal pure returns (string memory) {
        uint256 etherValue = weiAmount / 1e10;
        string memory etherStr = etherValue.toString();
        uint256 len = bytes(etherStr).length;
        while (len < 9) {
            etherStr = string(abi.encodePacked("0", etherStr));
            len++;
        }
        string memory integerPart = LibString.slice(etherStr, 0, len - 8);
        string memory decimalPart = LibString.slice(etherStr, len - 8, len);
        return string(abi.encodePacked(integerPart, ".", decimalPart));
    }

    function _deploy(string memory chain, string memory rpcUrl, uint32 eid) internal {
        address endpoint = endpointLookup[eid];
        if (endpoint == address(0)) revert InvalidEid();
        if (eids.contains(eid)) revert EidConfigured();
        if (endpoint == LZENDPOINT_SHARED) vm.label(endpoint, "Shared LayerZero Endpoint");
        else vm.label(endpoint, chain.concat(" LayerZero Endpoint | EID: ").concat(uint256(eid).toString()));

        uint256 forkId = vm.createFork(rpcUrl);
        vm.selectFork(forkId);
        vm.deal(msg.sender, 10 ether + msgValue);

        vm.startBroadcast();
        LayerZeroQuoter quoter = new LayerZeroQuoter(endpoint, msg.sender);
        vm.stopBroadcast();

        vm.label(address(quoter), chain.concat(" LayerZeroQuoter | EID: ").concat(uint256(eid).toString()));
        deployments[eid] = Deployment({chain: chain, addr: address(quoter), forkId: forkId});
        eids.add(eid);
    }

    function _configure() internal {
        uint256[] memory _eids = eids.values();
        for (uint256 i; i < _eids.length; ++i) {
            Deployment memory deployment = deployments[_eids[i]];
            vm.selectFork(deployment.forkId);
            LayerZeroQuoter quoter = LayerZeroQuoter(deployment.addr);
            vm.startBroadcast();
            for (uint256 j; j < _eids.length; ++j) {
                if (i == j) continue;
                Deployment memory peer = deployments[_eids[j]];
                quoter.setPeer(uint32(_eids[j]), _addressToBytes32(peer.addr));
            }
            vm.stopBroadcast();
        }
    }

    // Comment out the networks you don't want to test.
    // Don't forget to copy .env.example into .env and populate the RPC variables!
    // Run `source .env` in your terminal before you execute the scripts.
    function setUp() public {
        _deploy("Ethereum", vm.envString("ETHEREUM_RPC_URL"), EID_ETHEREUM);
        _deploy("BNB Chain", vm.envString("BNB_RPC_URL"), EID_BNB);
        _deploy("Avalanche", vm.envString("AVALANCHE_RPC_URL"), EID_AVALANCHE);
        _deploy("Polygon", vm.envString("POLYGON_RPC_URL"), EID_POLYGON);
        _deploy("Arbitrum", vm.envString("ARBITRUM_RPC_URL"), EID_ARBITRUM);
        _deploy("Optimism", vm.envString("OPTIMISM_RPC_URL"), EID_OPTIMISM);
        /*_deploy("Fantom", vm.envString("FANTOM_RPC_URL"), EID_FANTOM);
        _deploy("DFK", vm.envString("DFK_RPC_URL"), EID_DFK);
        _deploy("Harmony", vm.envString("HARMONY_RPC_URL"), EID_HARMONY);
        _deploy("Dexalot", vm.envString("DEXALOT_RPC_URL"), EID_DEXALOT);
        _deploy("Celo", vm.envString("CELO_RPC_URL"), EID_CELO);
        _deploy("Moonbeam", vm.envString("MOONBEAM_RPC_URL"), EID_MOONBEAM);
        _deploy("Fuse", vm.envString("FUSE_RPC_URL"), EID_FUSE);
        _deploy("Gnosis", vm.envString("GNOSIS_RPC_URL"), EID_GNOSIS);
        _deploy("DOS", vm.envString("DOS_RPC_URL"), EID_DOS);
        _deploy("Klaytn", vm.envString("KLAYTN_RPC_URL"), EID_KLAYTN);
        _deploy("Metis", vm.envString("METIS_RPC_URL"), EID_METIS);
        _deploy("CoreDAO", vm.envString("COREDAO_RPC_URL"), EID_COREDAO);
        _deploy("OKX", vm.envString("OKX_RPC_URL"), EID_OKX);
        _deploy("Polygon zkEVM", vm.envString("POLYGON_ZKEVM_RPC_URL"), EID_POLYGON_ZKEVM);
        _deploy("Canto", vm.envString("CANTO_RPC_URL"), EID_CANTO);
        _deploy("zkSync Era", vm.envString("ZKSYNC_ERA_RPC_URL"), EID_ZKSYNC_ERA);
        _deploy("Moonriver", vm.envString("MOONRIVER_RPC_URL"), EID_MOONRIVER);
        _deploy("Tenet", vm.envString("TENET_RPC_URL"), EID_TENET);
        _deploy("Arbitrum Nova", vm.envString("ARBITRUM_NOVA_RPC_URL"), EID_ARBITRUM_NOVA);
        _deploy("Meter.io", vm.envString("METER_IO_RPC_URL"), EID_METER_IO);
        _deploy("ShimmerEVM", vm.envString("SHIMMEREVM_RPC_URL"), EID_SHIMMEREVM);*/
        _configure();
    }

    function run() public {
        bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(gas, msgValue);
        uint256[] memory _eids = eids.values();

        console2.log("---------------- Mesh Network Quote Estimations ----------------");
        console2.log("");
        console2.log(LibString.concat("Number of chains in mesh: ", _eids.length.toString()));
        console2.log(LibString.concat("Units of gas spent: ", uint256(gas).toString()));
        console2.log(LibString.concat("Value delivered (in wei): ", uint256(msgValue).toString()));
        console2.log(LibString.concat("Value delivered (in ether): ", _weiToEtherString(msgValue)));
        console2.log(LibString.concat("Message length (in bytes): ", message.length.toString()));
        if (payInLzToken) console2.log("Pay in LZ token: true");
        else console2.log("Pay in LZ token: false");
        console2.log("");

        for (uint256 i; i < _eids.length; ++i) {
            Deployment memory deployment = deployments[_eids[i]];
            vm.selectFork(deployment.forkId);
            LayerZeroQuoter quoter = LayerZeroQuoter(deployment.addr);
            console2.log(LibString.concat("------- Source Chain: ", deployment.chain).concat(" -------"));
            console2.log("");
            vm.startBroadcast();
            for (uint256 j; j < _eids.length; ++j) {
                if (i == j) continue;
                Deployment memory destination = deployments[_eids[j]];
                (uint256 nativeFee, uint256 lzTokenFee) = quoter.quote(uint32(_eids[j]), message, options, payInLzToken);
                console2.log(LibString.concat("Destination: ", destination.chain));
                if (payInLzToken) {
                    console2.log(LibString.concat("LZ token fee (in wei): ", lzTokenFee.toString()));
                    console2.log(LibString.concat("LZ token fee (in ether): ", _weiToEtherString(lzTokenFee)));
                } else {
                    console2.log(LibString.concat("Native token fee (in wei): ", nativeFee.toString()));
                    console2.log(LibString.concat("Native token fee (in ether): ", _weiToEtherString(nativeFee)));
                }
                console2.log("");
            }
            vm.stopBroadcast();
            console2.log("----------------------------------------");
            console2.log("");
        }
        console2.log("----------------------------------------------------------------");
    }
}
