// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.23;

import {Script, console2} from "forge-std/Script.sol";
import {LZConfig} from "../src/LZConfig.sol";
import {LayerZeroQuoter} from "../src/LayerZeroQuoter.sol";
import {LibClone} from "../lib/solady/src/utils/LibClone.sol";
import {LibString} from "../lib/solady/src/utils/LibString.sol";
import {OptionsBuilder} from "../lib/LayerZero-v2/oapp/contracts/oapp/libs/OptionsBuilder.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract InboundQuoteScript is Script, LZConfig {
    using LibString for string;
    using LibString for uint256;
    using LibString for address;
    using OptionsBuilder for bytes;
    using EnumerableSet for EnumerableSet.UintSet;

    ///////////// CONFIGURE SCRIPT PARAMS HERE /////////////

    // Remember to adjust the setUp() function!
    uint32 internal dstEid = EID_ETHEREUM; // Source this from src/LZConfig.sol
    uint128 internal gas = 29_000; // Must be in units of gas, not in gwei
    uint128 internal msgValue = 0.01 ether;
    bytes internal message = abi.encode(address(420), abi.encodeWithSignature("placeBid(bytes32)", bytes32(bytes("zodomo"))));
    bool internal payInLzToken = false;
    // Remember to adjust the setUp() function!

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
        vm.deal(msg.sender, 10 ether);

        vm.startBroadcast();
        LayerZeroQuoter quoter = new LayerZeroQuoter(endpoint, msg.sender);
        vm.stopBroadcast();

        vm.label(address(quoter), chain.concat(" LayerZeroQuoter | EID: ").concat(uint256(eid).toString()));
        deployments[eid] = Deployment({chain: chain, addr: address(quoter), forkId: forkId});
        eids.add(eid);
    }

    function _configure() internal {
        uint256[] memory _eids = eids.values();
        Deployment memory destination = deployments[dstEid];
        for (uint256 i; i < _eids.length; ++i) {
            if (_eids[i] == dstEid) continue;
            Deployment memory peer = deployments[_eids[i]];
            vm.selectFork(peer.forkId);
            LayerZeroQuoter quoter = LayerZeroQuoter(peer.addr);
            vm.startBroadcast();
            quoter.setPeer(dstEid, _addressToBytes32(destination.addr));
            vm.stopBroadcast();
        }
    }

    // Comment out the networks you don't want to test.
    // Don't forget to copy .env.example into .env and populate the RPC variables!
    // Run `source .env` in your terminal before you execute the scripts.
    function setUp() public {
        // MAINNET
        /*_deploy("Ethereum", vm.envString("ETHEREUM_RPC_URL"), EID_ETHEREUM);
        _deploy("BNB", vm.envString("BNB_RPC_URL"), EID_BNB);
        _deploy("Avalanche", vm.envString("AVALANCHE_RPC_URL"), EID_AVALANCHE);
        _deploy("Polygon", vm.envString("POLYGON_RPC_URL"), EID_POLYGON);
        _deploy("Arbitrum", vm.envString("ARBITRUM_RPC_URL"), EID_ARBITRUM);
        _deploy("Optimism", vm.envString("OPTIMISM_RPC_URL"), EID_OPTIMISM);
        _deploy("Fantom", vm.envString("FANTOM_RPC_URL"), EID_FANTOM);
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
        _deploy("Polygon ZkEVM", vm.envString("POLYGON_ZKEVM_RPC_URL"), EID_POLYGON_ZKEVM);
        _deploy("Canto", vm.envString("CANTO_RPC_URL"), EID_CANTO);
        _deploy("Moonriver", vm.envString("MOONRIVER_RPC_URL"), EID_MOONRIVER);
        _deploy("Tenet", vm.envString("TENET_RPC_URL"), EID_TENET);
        _deploy("Arbitrum Nova", vm.envString("ARBITRUM_NOVA_RPC_URL"), EID_ARBITRUM_NOVA);
        _deploy("Kava", vm.envString("KAVA_RPC_URL"), EID_KAVA);
        _deploy("Mantle", vm.envString("MANTLE_RPC_URL"), EID_MANTLE);
        _deploy("Hubble", vm.envString("HUBBLE_RPC_URL"), EID_HUBBLE);
        _deploy("Linea", vm.envString("LINEA_RPC_URL"), EID_LINEA);
        _deploy("Base", vm.envString("BASE_RPC_URL"), EID_BASE);
        _deploy("Zora", vm.envString("ZORA_RPC_URL"), EID_ZORA);
        _deploy("Viction", vm.envString("VICTION_RPC_URL"), EID_VICTION);
        _deploy("Loot", vm.envString("LOOT_RPC_URL"), EID_LOOT);
        _deploy("Merit Circle", vm.envString("MERIT_CIRCLE_RPC_URL"), EID_MERIT_CIRCLE);
        _deploy("Telos", vm.envString("TELOS_RPC_URL"), EID_TELOS);
        _deploy("OpBNB", vm.envString("OPBNB_RPC_URL"), EID_OPBNB);
        _deploy("Astar", vm.envString("ASTAR_RPC_URL"), EID_ASTAR);
        _deploy("Aurora", vm.envString("AURORA_RPC_URL"), EID_AURORA);
        _deploy("Conflux", vm.envString("CONFLUX_RPC_URL"), EID_CONFLUX);
        _deploy("Orderly", vm.envString("ORDERLY_RPC_URL"), EID_ORDERLY);
        _deploy("Scroll", vm.envString("SCROLL_RPC_URL"), EID_SCROLL);
        _deploy("Horizen Eon", vm.envString("HORIZEN_EON_RPC_URL"), EID_HORIZEN_EON);
        _deploy("Xpla", vm.envString("XPLA_RPC_URL"), EID_XPLA);
        _deploy("Manta", vm.envString("MANTA_RPC_URL"), EID_MANTA);
        _deploy("Rarible", vm.envString("RARIBLE_RPC_URL"), EID_RARIBLE);
        _deploy("XAI", vm.envString("XAI_RPC_URL"), EID_XAI);
        _deploy("Injective", vm.envString("INJECTIVE_RPC_URL"), EID_INJECTIVE);
        _deploy("Fraxtal", vm.envString("FRAXTAL_RPC_URL"), EID_FRAXTAL);
        _deploy("Blast", vm.envString("BLAST_RPC_URL"), EID_BLAST);
        _deploy("Astar ZkEVM", vm.envString("ASTAR_ZKEVM_RPC_URL"), EID_ASTAR_ZKEVM);
        _deploy("Mode", vm.envString("MODE_RPC_URL"), EID_MODE);
        _deploy("zkSync Era", vm.envString("ZKSYNC_ERA_RPC_URL"), EID_ZKSYNC_ERA);
        _deploy("Meter IO", vm.envString("METER_IO_RPC_URL"), EID_METER_IO);
        _deploy("ShimmerEVM", vm.envString("SHIMMEREVM_RPC_URL"), EID_SHIMMEREVM);
        _deploy("Tiltyard", vm.envString("TILTYARD_RPC_URL"), EID_TILTYARD);*/

        // TESTNET
        /*_deploy("Sepolia Testnet", vm.envString("SEPOLIA_TESTNET_RPC_URL"), EID_SEPOLIA_TESTNET);
        _deploy("BNB Chain Testnet", vm.envString("BNB_CHAIN_TESTNET_RPC_URL"), EID_BNB_CHAIN_TESTNET);
        _deploy("Fuji Avalanche Testnet", vm.envString("FUJI_AVALANCHE_TESTNET_RPC_URL"), EID_FUJI_AVALANCHE_TESTNET);
        _deploy("Mumbai Polygon Testnet", vm.envString("MUMBAI_POLYGON_TESTNET_RPC_URL"), EID_MUMBAI_POLYGON_TESTNET);
        _deploy("Arbitrum Sepolia Testnet", vm.envString("ARBITRUM_SEPOLIA_TESTNET_RPC_URL"), EID_ARBITRUM_SEPOLIA_TESTNET);
        _deploy("Optimism Sepolia Testnet", vm.envString("OPTIMISM_SEPOLIA_TESTNET_RPC_URL"), EID_OPTIMISM_SEPOLIA_TESTNET);
        _deploy("Fantom Testnet", vm.envString("FANTOM_TESTNET_RPC_URL"), EID_FANTOM_TESTNET);
        _deploy("Celo Testnet", vm.envString("CELO_TESTNET_RPC_URL"), EID_CELO_TESTNET);
        _deploy("Moonbeam Testnet", vm.envString("MOONBEAM_TESTNET_RPC_URL"), EID_MOONBEAM_TESTNET);
        _deploy("Fuse Testnet", vm.envString("FUSE_TESTNET_RPC_URL"), EID_FUSE_TESTNET);
        _deploy("Gnosis Testnet", vm.envString("GNOSIS_TESTNET_RPC_URL"), EID_GNOSIS_TESTNET);
        _deploy("Klaytn Testnet", vm.envString("KLAYTN_TESTNET_RPC_URL"), EID_KLAYTN_TESTNET);
        _deploy("Metis Testnet", vm.envString("METIS_TESTNET_RPC_URL"), EID_METIS_TESTNET);
        _deploy("CoreDAO Testnet", vm.envString("COREDAO_TESTNET_RPC_URL"), EID_COREDAO_TESTNET);
        _deploy("OKX Testnet", vm.envString("OKX_TESTNET_RPC_URL"), EID_OKX_TESTNET);
        _deploy("Meter IO Testnet", vm.envString("METER_IO_TESTNET_RPC_URL"), EID_METER_IO_TESTNET);
        _deploy("Linea zkConsensys Testnet", vm.envString("LINEA_ZKCONSENSYS_TESTNET_RPC_URL"), EID_LINEA_ZKCONSENSYS_TESTNET);
        _deploy("Canto Testnet", vm.envString("CANTO_TESTNET_RPC_URL"), EID_CANTO_TESTNET);
        _deploy("Scroll Testnet", vm.envString("SCROLL_TESTNET_RPC_URL"), EID_SCROLL_TESTNET);
        _deploy("Tenet Testnet", vm.envString("TENET_TESTNET_RPC_URL"), EID_TENET_TESTNET);
        _deploy("Kava Testnet", vm.envString("KAVA_TESTNET_RPC_URL"), EID_KAVA_TESTNET);
        _deploy("Merit Circle Testnet", vm.envString("MERIT_CIRCLE_TESTNET_RPC_URL"), EID_MERIT_CIRCLE_TESTNET);
        _deploy("Mantle Testnet", vm.envString("MANTLE_TESTNET_RPC_URL"), EID_MANTLE_TESTNET);
        _deploy("Viction Testnet", vm.envString("VICTION_TESTNET_RPC_URL"), EID_VICTION_TESTNET);
        _deploy("Loot Testnet", vm.envString("LOOT_TESTNET_RPC_URL"), EID_LOOT_TESTNET);
        _deploy("Telos Testnet", vm.envString("TELOS_TESTNET_RPC_URL"), EID_TELOS_TESTNET);
        _deploy("Orderly Testnet OpStack", vm.envString("ORDERLY_TESTNET_OPSTACK_RPC_URL"), EID_ORDERLY_TESTNET_OPSTACK);
        _deploy("OpBNB Testnet", vm.envString("OPBNB_TESTNET_RPC_URL"), EID_OPBNB_TESTNET);
        _deploy("Astar EVM Testnet", vm.envString("ASTAR_EVM_TESTNET_RPC_URL"), EID_ASTAR_EVM_TESTNET);
        _deploy("Conflux Testnet", vm.envString("CONFLUX_TESTNET_RPC_URL"), EID_CONFLUX_TESTNET);
        _deploy("Xpla Testnet", vm.envString("XPLA_TESTNET_RPC_URL"), EID_XPLA_TESTNET);
        _deploy("Holesky Testnet", vm.envString("HOLESKY_TESTNET_RPC_URL"), EID_HOLESKY_TESTNET);
        _deploy("Rarible Testnet", vm.envString("RARIBLE_TESTNET_RPC_URL"), EID_RARIBLE_TESTNET);
        _deploy("Japan Open Chain Testnet", vm.envString("JAPAN_OPEN_CHAIN_TESTNET_RPC_URL"), EID_JAPAN_OPEN_CHAIN_TESTNET);
        _deploy("Blast Testnet", vm.envString("BLAST_TESTNET_RPC_URL"), EID_BLAST_TESTNET);
        _deploy("Base Sepolia Testnet", vm.envString("BASE_SEPOLIA_RPC_URL"), EID_BASE_SEPOLIA);
        _deploy("Mantle Sepolia Testnet", vm.envString("MANTLE_SEPOLIA_RPC_URL"), EID_MANTLE_SEPOLIA);
        _deploy("Polygon ZkEVM Sepolia Testnet", vm.envString("POLYGON_ZKEVM_SEPOLIA_RPC_URL"), EID_POLYGON_ZKEVM_SEPOLIA);
        _deploy("Zora Sepolia Testnet", vm.envString("ZORA_SEPOLIA_RPC_URL"), EID_ZORA_SEPOLIA);
        _deploy("XAI Testnet", vm.envString("XAI_TESTNET_RPC_URL"), EID_XAI_TESTNET);
        _deploy("Tangible Testnet", vm.envString("TANGIBLE_TESTNET_RPC_URL"), EID_TANGIBLE_TESTNET);
        _deploy("Skale Testnet", vm.envString("SKALE_TESTNET_RPC_URL"), EID_SKALE_TESTNET);
        _deploy("Fraxtal Testnet", vm.envString("FRAXTAL_TESTNET_RPC_URL"), EID_FRAXTAL_TESTNET);
        _deploy("Berachain Testnet", vm.envString("BERACHAIN_TESTNET_RPC_URL"), EID_BERACHAIN_TESTNET);
        _deploy("Mode Testnet", vm.envString("MODE_TESTNET_RPC_URL"), EID_MODE_TESTNET);
        _deploy("Sei Testnet", vm.envString("SEI_TESTNET_RPC_URL"), EID_SEI_TESTNET);
        _deploy("Unreal Testnet", vm.envString("UNREAL_TESTNET_RPC_URL"), EID_UNREAL_TESTNET);
        _deploy("Masa Testnet", vm.envString("MASA_TESTNET_RPC_URL"), EID_MASA_TESTNET);
        _deploy("Merlin Chain Testnet", vm.envString("MERLIN_CHAIN_TESTNET_RPC_URL"), EID_MERLIN_CHAIN_TESTNET);
        _deploy("Meter IO Testnet", vm.envString("METER_IO_TESTNET_RPC_URL"), EID_METER_IO_TESTNET);
        _deploy("Etherlink Testnet", vm.envString("ETHERLINK_TESTNET_RPC_URL"), EID_ETHERLINK_TESTNET);*/

        _configure();
    }

    function run() public {
        bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(gas, msgValue);
        uint256[] memory _eids = eids.values();
        Deployment memory destination = deployments[dstEid];

        console2.log(LibString.concat("------- ", destination.chain.concat(" Inbound Quote Estimations -------")));
        console2.log("");
        console2.log(LibString.concat("Number of origin chains: ", uint256(_eids.length - 1).toString()));
        console2.log(LibString.concat("Units of gas spent: ", uint256(gas).toString()));
        console2.log(LibString.concat("Value delivered (in wei units): ", uint256(msgValue).toString()));
        console2.log(LibString.concat("Value delivered (in ether units): ", _weiToEtherString(msgValue)));
        console2.log(LibString.concat("Message length (in bytes): ", message.length.toString()));
        if (payInLzToken) console2.log("Pay in LZ token: true");
        else console2.log("Pay in LZ token: false");
        console2.log("");

        for (uint256 i; i < _eids.length; ++i) {
            if (_eids[i] == dstEid) continue;
            Deployment memory deployment = deployments[_eids[i]];
            vm.selectFork(deployment.forkId);
            LayerZeroQuoter quoter = LayerZeroQuoter(deployment.addr);
            vm.startBroadcast();
            (uint256 nativeFee, uint256 lzTokenFee) = quoter.quote(dstEid, message, options, payInLzToken);
            vm.stopBroadcast();
            console2.log(LibString.concat("Origin: ", deployment.chain));
            if (payInLzToken) {
                console2.log(LibString.concat("LZ token fee (in wei units): ", lzTokenFee.toString()));
                console2.log(LibString.concat("LZ token fee (in ether units): ", _weiToEtherString(lzTokenFee)));
            } else {
                console2.log(LibString.concat("Native token fee (in wei units): ", nativeFee.toString()));
                console2.log(LibString.concat("Native token fee (in ether units): ", _weiToEtherString(nativeFee)));
            }
            console2.log("");
        }
        console2.log("--------------------------------------------------");
    }
}