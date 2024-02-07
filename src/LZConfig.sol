// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.23;

abstract contract LZConfig {
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

    // Chain EIDs and LZ Endpoint addresses for chains that don't have the shared endpoint address
    address internal constant LZENDPOINT_ZKSYNC_ERA = 0xd07C30aF3Ff30D96BDc9c6044958230Eb797DDBF;
    uint32 internal constant EID_ZKSYNC_ERA = 30165;
    address internal constant LZENDPOINT_METER_IO = 0xef02BacD67C0AB45510927749009F6B9ffCE0631;
    uint32 internal constant EID_METER_IO = 30176;
    address internal constant LZENDPOINT_SHIMMEREVM = 0x148f693af10ddfaE81cDdb36F4c93B31A90076e1;
    uint32 internal constant EID_SHIMMEREVM = 30230;

    mapping(uint32 eid => address endpoint) internal endpointLookup;

    constructor() {
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

        // Networks with unique LZ Endpoint addresses
        endpointLookup[EID_ZKSYNC_ERA] = LZENDPOINT_ZKSYNC_ERA;
        endpointLookup[EID_METER_IO] = LZENDPOINT_METER_IO;
        endpointLookup[EID_SHIMMEREVM] = LZENDPOINT_SHIMMEREVM;
    }
}
