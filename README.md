<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
<h3 align="center">LayerZeroQuoter</h3>

  <p align="center">
    Foundry tooling to help assess costs when using LayerZero V2. Quote enumeration is performed entirely offchain.
    <br />
    <br />
    <a href="https://github.com/Zodomo/LayerZeroQuoter/issues">Report Bug</a>
    ·
    <a href="https://github.com/Zodomo/LayerZeroQuoter/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is primarily a set of foundry scripts that are designed to make it very easy to get quotes for a particular payload using a variety of routes, completely offchain. It supports performing quotes from a specific source chain to N destination chains, or performing full mesh enumeration for a set of chains so you can identify the cheapest routes.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Ethereum][Ethereum.com]][Ethereum-url]
* [![Solidity][Solidity.sol]][Solidity-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

LayerZeroQuoter was designed using Foundry, so I recommend familiarizing yourself with that if required.

### Prerequisites

* Install Foundry
  ```sh
  curl -L https://foundry.paradigm.xyz | bash
  foundryup
  ```

### Installation

1. Clone this repo:
    ```text
    git clone https://github.com/Zodomo/LayerZeroQuoter
    cd LayerZeroQuoter
    ```
2. Install LayerZeroQuoter:
    ```text
    forge install
    ```
3. Install LayerZero-v2 dependencies
    ```text
    cd lib/LayerZero-v2
    yarn
    yarn build
    cd ../..
    ```
4. Copy .env.example into .env:
    ```text
    cp ./.env.example ./.env
    ```
5. Populate the RPC URLs for the chains you want to test in .env, save it, and then run:
    ```text
    source .env
    ``````

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

1. Pick any of the scripts in `./scripts/` and modify the variables near the top of the script you want to run.</br>
    MeshQuote.s.sol:
    ```solidity
    uint128 internal gas = 50_000; // Must be in units of gas, not in gwei
    uint128 internal msgValue = 0.01 ether;
    bytes internal message = abi.encode("Zodomo");
    bool internal payInLzToken = false;
    ```
    OutboundQuote.s.sol:
    ```solidity
    uint32 internal srcEid = EID_MAINNET; // Source this in src/LZConfig.sol
    uint128 internal gas = 50_000; // Must be in units of gas, not in gwei
    uint128 internal msgValue = 0.01 ether;
    bytes internal message = abi.encode("Zodomo");
    bool internal payInLzToken = false;
    ```
    InboundQuote.s.sol:
    ```solidity
    uint32 internal dstEid = EID_MAINNET; // Source this in src/LZConfig.sol
    uint128 internal gas = 50_000; // Must be in units of gas, not in gwei
    uint128 internal msgValue = 0.01 ether;
    bytes internal message = abi.encode("Zodomo");
    bool internal payInLzToken = false;
    ```
</br>

2. Comment and/or uncomment each _deploy() call in the specified script's setUp() function to configure which chains you are testing.</br>
    Example:
    ```solidity
    _deploy("Ethereum", vm.envString("ETHEREUM_RPC_URL"), EID_ETHEREUM);
    //_deploy("BNB Chain", vm.envString("BNB_RPC_URL"), EID_BNB);
    //_deploy("Avalanche", vm.envString("AVALANCHE_RPC_URL"), EID_AVALANCHE);
    _deploy("Polygon", vm.envString("POLYGON_RPC_URL"), EID_POLYGON);
    _deploy("Arbitrum", vm.envString("ARBITRUM_RPC_URL"), EID_ARBITRUM);
    _deploy("Optimism", vm.envString("OPTIMISM_RPC_URL"), EID_OPTIMISM);
    ```
</br>

3. Lastly, execute your preferred script using one of the following commands (be careful not to broadcast, as that is not necessary).</br>
    ```sh
    forge script script/InboundQuote.s.sol --sig "run()" -vvv
    ```
    ```sh
    forge script script/OutboundQuote.s.sol --sig "run()" -vvv
    ```
    ```sh
    forge script script/MeshQuote.s.sol --sig "run()" -vvv
    ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the CC0-1.0 License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Zodomo: [Farcaster](https://warpcast.com/zodomo) - [Twitter](https://twitter.com/0xZodomo) - [Email](mailto:zodomo@proton.me) - Zodomo.eth - zodomo/

Project Link: [https://github.com/Zodomo/LayerZeroQuoter](https://github.com/Zodomo/LayerZeroQuoter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [LayerZero](https://layerzero.network/)
* [Solady by Vectorized.eth](https://github.com/Vectorized/solady)
* [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Zodomo/LayerZeroQuoter.svg?style=for-the-badge
[contributors-url]: https://github.com/Zodomo/LayerZeroQuoter/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Zodomo/LayerZeroQuoter.svg?style=for-the-badge
[forks-url]: https://github.com/Zodomo/LayerZeroQuoter/network/members
[stars-shield]: https://img.shields.io/github/stars/Zodomo/LayerZeroQuoter.svg?style=for-the-badge
[stars-url]: https://github.com/Zodomo/LayerZeroQuoter/stargazers
[issues-shield]: https://img.shields.io/github/issues/Zodomo/LayerZeroQuoter.svg?style=for-the-badge
[issues-url]: https://github.com/Zodomo/LayerZeroQuoter/issues
[Ethereum.com]: https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white
[Ethereum-url]: https://ethereum.org/
[Solidity.sol]: https://img.shields.io/badge/Solidity-e6e6e6?style=for-the-badge&logo=solidity&logoColor=black
[Solidity-url]: https://soliditylang.org/