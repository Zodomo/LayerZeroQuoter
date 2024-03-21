// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.23;

abstract contract LZConfig {
    /// MAINNET
    // EIDs for networks that use the shared LZ Endpoint address
    address internal constant LZENDPOINT_SHARED = 0x1a44076050125825900e736c501f859c50fE728c;
    uint32 internal constant EID_ETHEREUM = 30101;
    uint32 internal constant EID_BNB = 30102;
    uint32 internal constant EID_AVALANCHE = 30106;
    uint32 internal constant EID_POLYGON = 30109;
    uint32 internal constant EID_ARBITRUM = 30110;
    uint32 internal constant EID_OPTIMISM = 30111;
    uint32 internal constant EID_FANTOM = 30112;
    uint32 internal constant EID_DFK = 30115;
    uint32 internal constant EID_HARMONY = 30116;
    uint32 internal constant EID_DEXALOT = 30118;
    uint32 internal constant EID_CELO = 30125;
    uint32 internal constant EID_MOONBEAM = 30126;
    uint32 internal constant EID_FUSE = 30138;
    uint32 internal constant EID_GNOSIS = 30145;
    uint32 internal constant EID_DOS = 30149;
    uint32 internal constant EID_KLAYTN = 30150;
    uint32 internal constant EID_METIS = 30151;
    uint32 internal constant EID_COREDAO = 30153;
    uint32 internal constant EID_OKX = 30155;
    uint32 internal constant EID_POLYGON_ZKEVM = 30158;
    uint32 internal constant EID_CANTO = 30159;
    uint32 internal constant EID_MOONRIVER = 30167;
    uint32 internal constant EID_TENET = 30173;
    uint32 internal constant EID_ARBITRUM_NOVA = 30175;
    uint32 internal constant EID_KAVA = 30177;
    uint32 internal constant EID_MANTLE = 30181;
    uint32 internal constant EID_HUBBLE = 30182;
    uint32 internal constant EID_LINEA = 30183;
    uint32 internal constant EID_BASE = 30184;
    uint32 internal constant EID_ZORA = 30195;
    uint32 internal constant EID_VICTION = 30196;
    uint32 internal constant EID_LOOT = 30197;
    uint32 internal constant EID_MERIT_CIRCLE = 30198;
    uint32 internal constant EID_TELOS = 30199;
    uint32 internal constant EID_OPBNB = 30202;
    uint32 internal constant EID_ASTAR = 30210;
    uint32 internal constant EID_AURORA = 30211;
    uint32 internal constant EID_CONFLUX = 30212;
    uint32 internal constant EID_ORDERLY = 30213;
    uint32 internal constant EID_SCROLL = 30214;
    uint32 internal constant EID_HORIZEN_EON = 30215;
    uint32 internal constant EID_XPLA = 30216;
    uint32 internal constant EID_MANTA = 30217;
    uint32 internal constant EID_RARIBLE = 30235;
    uint32 internal constant EID_XAI = 30236;
    uint32 internal constant EID_INJECTIVE = 30234;
    uint32 internal constant EID_FRAXTAL = 30255;
    uint32 internal constant EID_BLAST = 30243;
    uint32 internal constant EID_ASTAR_ZKEVM = 30257;
    uint32 internal constant EID_MODE = 30260;

    // Chain EIDs and LZ Endpoint addresses for chains that don't have the shared endpoint address
    address internal constant LZENDPOINT_ZKSYNC_ERA = 0xd07C30aF3Ff30D96BDc9c6044958230Eb797DDBF;
    uint32 internal constant EID_ZKSYNC_ERA = 30165;
    address internal constant LZENDPOINT_METER_IO = 0xef02BacD67C0AB45510927749009F6B9ffCE0631;
    uint32 internal constant EID_METER_IO = 30176;
    address internal constant LZENDPOINT_SHIMMEREVM = 0x148f693af10ddfaE81cDdb36F4c93B31A90076e1;
    uint32 internal constant EID_SHIMMEREVM = 30230;
    address internal constant LZENDPOINT_TILTYARD = 0x3A73033C0b1407574C76BdBAc67f126f6b4a9AA9;
    uint32 internal constant EID_TILTYARD = 30238;

    /// TESTNET
    // EIDs for testnets that use the shared LZ Endpoint address
    address internal constant LZENDPOINT_SHARED_TESTNET = 0x6EDCE65403992e310A62460808c4b910D972f10f;
    uint32 internal constant EID_SEPOLIA_TESTNET = 40161;
    uint32 internal constant EID_BNB_CHAIN_TESTNET = 40102;
    uint32 internal constant EID_FUJI_AVALANCHE_TESTNET = 40106;
    uint32 internal constant EID_MUMBAI_POLYGON_TESTNET = 40109;
    uint32 internal constant EID_ARBITRUM_SEPOLIA_TESTNET = 40231;
    uint32 internal constant EID_OPTIMISM_SEPOLIA_TESTNET = 40232;
    uint32 internal constant EID_FANTOM_TESTNET = 40112;
    uint32 internal constant EID_CELO_TESTNET = 40125;
    uint32 internal constant EID_MOONBEAM_TESTNET = 40126;
    uint32 internal constant EID_FUSE_TESTNET = 40138;
    uint32 internal constant EID_GNOSIS_TESTNET = 40145;
    uint32 internal constant EID_KLAYTN_TESTNET = 40150;
    uint32 internal constant EID_METIS_TESTNET = 40151;
    uint32 internal constant EID_COREDAO_TESTNET = 40153;
    uint32 internal constant EID_OKX_TESTNET = 40155;
    uint32 internal constant EID_LINEA_ZKCONSENSYS_TESTNET = 40157;
    uint32 internal constant EID_CANTO_TESTNET = 40159;
    uint32 internal constant EID_SCROLL_TESTNET = 40170;
    uint32 internal constant EID_TENET_TESTNET = 40173;
    uint32 internal constant EID_KAVA_TESTNET = 40177;
    uint32 internal constant EID_MERIT_CIRCLE_TESTNET = 40178;
    uint32 internal constant EID_MANTLE_TESTNET = 40181;
    uint32 internal constant EID_VICTION_TESTNET = 40196;
    uint32 internal constant EID_LOOT_TESTNET = 40197;
    uint32 internal constant EID_TELOS_TESTNET = 40199;
    uint32 internal constant EID_ORDERLY_TESTNET_OPSTACK = 40200;
    uint32 internal constant EID_OPBNB_TESTNET = 40202;
    uint32 internal constant EID_ASTAR_EVM_TESTNET = 40210;
    uint32 internal constant EID_CONFLUX_TESTNET = 40211;
    uint32 internal constant EID_XPLA_TESTNET = 40216;
    uint32 internal constant EID_HOLESKY_TESTNET = 40217;
    uint32 internal constant EID_RARIBLE_TESTNET = 40235;
    uint32 internal constant EID_JAPAN_OPEN_CHAIN_TESTNET = 40242;
    uint32 internal constant EID_BLAST_TESTNET = 40243;
    uint32 internal constant EID_BASE_SEPOLIA = 40245;
    uint32 internal constant EID_MANTLE_SEPOLIA = 40246;
    uint32 internal constant EID_POLYGON_ZKEVM_SEPOLIA = 40247;
    uint32 internal constant EID_ZORA_SEPOLIA = 40249;
    uint32 internal constant EID_XAI_TESTNET = 40251;
    uint32 internal constant EID_TANGIBLE_TESTNET = 40252;
    uint32 internal constant EID_SKALE_TESTNET = 40254;
    uint32 internal constant EID_FRAXTAL_TESTNET = 40255;
    uint32 internal constant EID_BERACHAIN_TESTNET = 40256;
    uint32 internal constant EID_MODE_TESTNET = 40260;
    uint32 internal constant EID_SEI_TESTNET = 40258;
    uint32 internal constant EID_UNREAL_TESTNET = 40262;
    uint32 internal constant EID_MASA_TESTNET = 40263;
    uint32 internal constant EID_MERLIN_CHAIN_TESTNET = 40264;

    // Chain EIDs and LZ Endpoint addresses for testnets that don't have the shared endpoint address
    address internal constant LZENDPOINT_METER_IO_TESTNET = 0x3E03163f253ec436d4562e5eFd038cf98827B7eC;
    uint32 internal constant EID_METER_IO_TESTNET = 40156;
    address internal constant LZENDPOINT_ETHERLINK_TESTNET = 0xec28645346D781674B4272706D8a938dB2BAA2C6;
    uint32 internal constant EID_ETHERLINK_TESTNET = 40239;

    mapping(uint32 eid => address endpoint) internal endpointLookup;

    constructor() {
        /// MAINNET
        // Networks using the shared LZ Endpoint
        endpointLookup[EID_ETHEREUM] = LZENDPOINT_SHARED;
        endpointLookup[EID_BNB] = LZENDPOINT_SHARED;
        endpointLookup[EID_AVALANCHE] = LZENDPOINT_SHARED;
        endpointLookup[EID_POLYGON] = LZENDPOINT_SHARED;
        endpointLookup[EID_ARBITRUM] = LZENDPOINT_SHARED;
        endpointLookup[EID_OPTIMISM] = LZENDPOINT_SHARED;
        endpointLookup[EID_FANTOM] = LZENDPOINT_SHARED;
        endpointLookup[EID_DFK] = LZENDPOINT_SHARED;
        endpointLookup[EID_HARMONY] = LZENDPOINT_SHARED;
        endpointLookup[EID_DEXALOT] = LZENDPOINT_SHARED;
        endpointLookup[EID_CELO] = LZENDPOINT_SHARED;
        endpointLookup[EID_MOONBEAM] = LZENDPOINT_SHARED;
        endpointLookup[EID_FUSE] = LZENDPOINT_SHARED;
        endpointLookup[EID_GNOSIS] = LZENDPOINT_SHARED;
        endpointLookup[EID_DOS] = LZENDPOINT_SHARED;
        endpointLookup[EID_KLAYTN] = LZENDPOINT_SHARED;
        endpointLookup[EID_METIS] = LZENDPOINT_SHARED;
        endpointLookup[EID_COREDAO] = LZENDPOINT_SHARED;
        endpointLookup[EID_OKX] = LZENDPOINT_SHARED;
        endpointLookup[EID_POLYGON_ZKEVM] = LZENDPOINT_SHARED;
        endpointLookup[EID_CANTO] = LZENDPOINT_SHARED;
        endpointLookup[EID_MOONRIVER] = LZENDPOINT_SHARED;
        endpointLookup[EID_TENET] = LZENDPOINT_SHARED;
        endpointLookup[EID_ARBITRUM_NOVA] = LZENDPOINT_SHARED;
        endpointLookup[EID_KAVA] = LZENDPOINT_SHARED;
        endpointLookup[EID_MANTLE] = LZENDPOINT_SHARED;
        endpointLookup[EID_HUBBLE] = LZENDPOINT_SHARED;
        endpointLookup[EID_LINEA] = LZENDPOINT_SHARED;
        endpointLookup[EID_BASE] = LZENDPOINT_SHARED;
        endpointLookup[EID_ZORA] = LZENDPOINT_SHARED;
        endpointLookup[EID_VICTION] = LZENDPOINT_SHARED;
        endpointLookup[EID_LOOT] = LZENDPOINT_SHARED;
        endpointLookup[EID_MERIT_CIRCLE] = LZENDPOINT_SHARED;
        endpointLookup[EID_TELOS] = LZENDPOINT_SHARED;
        endpointLookup[EID_OPBNB] = LZENDPOINT_SHARED;
        endpointLookup[EID_ASTAR] = LZENDPOINT_SHARED;
        endpointLookup[EID_AURORA] = LZENDPOINT_SHARED;
        endpointLookup[EID_CONFLUX] = LZENDPOINT_SHARED;
        endpointLookup[EID_ORDERLY] = LZENDPOINT_SHARED;
        endpointLookup[EID_SCROLL] = LZENDPOINT_SHARED;
        endpointLookup[EID_HORIZEN_EON] = LZENDPOINT_SHARED;
        endpointLookup[EID_XPLA] = LZENDPOINT_SHARED;
        endpointLookup[EID_MANTA] = LZENDPOINT_SHARED;
        endpointLookup[EID_RARIBLE] = LZENDPOINT_SHARED;
        endpointLookup[EID_XAI] = LZENDPOINT_SHARED;
        endpointLookup[EID_INJECTIVE] = LZENDPOINT_SHARED;
        endpointLookup[EID_FRAXTAL] = LZENDPOINT_SHARED;
        endpointLookup[EID_BLAST] = LZENDPOINT_SHARED;
        endpointLookup[EID_ASTAR_ZKEVM] = LZENDPOINT_SHARED;
        endpointLookup[EID_MODE] = LZENDPOINT_SHARED;

        // Networks with unique LZ Endpoint addresses
        endpointLookup[EID_ZKSYNC_ERA] = LZENDPOINT_ZKSYNC_ERA;
        endpointLookup[EID_METER_IO] = LZENDPOINT_METER_IO;
        endpointLookup[EID_SHIMMEREVM] = LZENDPOINT_SHIMMEREVM;
        endpointLookup[EID_TILTYARD] = LZENDPOINT_TILTYARD;

        /// TESTNET
        // Networks using the shared LZ Endpoint
        endpointLookup[EID_SEPOLIA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_BNB_CHAIN_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_FUJI_AVALANCHE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MUMBAI_POLYGON_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_ARBITRUM_SEPOLIA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_OPTIMISM_SEPOLIA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_FANTOM_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_CELO_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MOONBEAM_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_FUSE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_GNOSIS_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_KLAYTN_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_METIS_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_COREDAO_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_OKX_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_LINEA_ZKCONSENSYS_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_CANTO_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_SCROLL_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_TENET_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_KAVA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MERIT_CIRCLE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MANTLE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_VICTION_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_LOOT_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_TELOS_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_ORDERLY_TESTNET_OPSTACK] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_OPBNB_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_ASTAR_EVM_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_CONFLUX_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_XPLA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_HOLESKY_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_RARIBLE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_JAPAN_OPEN_CHAIN_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_BLAST_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_BASE_SEPOLIA] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MANTLE_SEPOLIA] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_POLYGON_ZKEVM_SEPOLIA] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_ZORA_SEPOLIA] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_XAI_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_TANGIBLE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_SKALE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_FRAXTAL_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_BERACHAIN_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MODE_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_SEI_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_UNREAL_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MASA_TESTNET] = LZENDPOINT_SHARED_TESTNET;
        endpointLookup[EID_MERLIN_CHAIN_TESTNET] = LZENDPOINT_SHARED_TESTNET;

        // Networks with unique LZ Endpoint addresses
        endpointLookup[EID_METER_IO_TESTNET] = LZENDPOINT_METER_IO_TESTNET;
        endpointLookup[EID_ETHERLINK_TESTNET] = LZENDPOINT_ETHERLINK_TESTNET;
    }
}