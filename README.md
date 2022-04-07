# Voronoi &middot; [![GitHub license](https://img.shields.io/badge/license-GPL3%2FApache2-blue)](https://github.com/Qrucial/voronoi/blob/main/LICENSE)
Making "decentralized" blockchain projects actually decentralized and more secure.
We take Substrate as our base system, implement ECDSA signing and verification logics for solving issues related to single point of failures and code that centralizes projecets.

### Assumption
There are high demand projects that include decentralization and security in their core principles.

There is a need for removing single accounts controling large amount of funds in smart contracts and other decentralized systems.

### Problem
The existence of (SPoF) single point of failures in systems that are meant to be decentralized.

### SPoF examples
The smart contract can be controlled (withdraw or pause) by a single account
What if the single account is hacked? Smart contract emptied and stopped/destroyed.
DApp with legacy, centralized backend
What if the backend hacked? DApp replaced with malicious smart contract.
DApp cannot be run locally, just from a central website
What if the domain or the DNS is hacked? DApp replaced with malicious smart contract.

### Solutions:
On smart contract level: Sign Flow Critical actions with multiple parties before executing them.
DecentraLib.sol
Use of threshold wallets (problem with that is not transparent enough)
On DApp level: share the source code and run-able binary/script in multiple locations and sign them/make them verifiable
Use of vanillajs + polkadotjs/web3js
Push code to Gitea/Github/Gitlab
Always publish the address on multiple public sources so users can verify it before transaction (website, twitter, telegram)

### Teminology

| Term | Explanation |
| ------ | ------ |
| Single Point of Failure (SPoF)  |A point in the system that in case of incident makes the whole or major part the system fail. |
| Organization Flow (OrgFlow) | The project being executed, including the steps on the paths that are being taken. |
| Critical Impact Function (CIF) | Functions that are critical in the flow of the project's execution (eg. a selfdestruct() call stopping the whole Project Flow). |
| Minor Impact Function (MIF) | Minor Impact Function (MIF) - Functions that cannot have a critical impact on the project. |

### Roles (DRAFT)
| Term | What is allowed |
| ------ | ------ |
| Voter | Accounts in listed in the Voter role can vote on action unlocks. |
| Executive | If a specific account is needed to be used for calling an unlocked action, this/these user(s) are the only one(s) who can execute.|
| Everyone | Everyone else. They are not allowed to call or modify anything in the contract. |

### Current state of Voronoi
Original vision started with smart contracts and signature logic.

The best option so far looks like forking Substrate and buliding a pallet system.

Voronoi-signature pallet -> verify and sign messages based on decentralized authorization logic

Voronoi stays on "rust level".

We take as much vanilla Substrate as we can. Just add required solution for the signing.

Start with sudo and remove it later for community governance.

Voronoi coin to be used for registering in the system and also to get verification and sign -> Pallet.

We need to give examples on how to connect eg. Solidity to Voronoi.

Voronoit toolbox.

We start with signature solution for devlopment. First figure out format for Solidity.


### Example Topology of a real decentralized smart contract
![Decentralized Organization](/images/DecentraLibExample.jpg)


### Voronoi on Moonbase Alpha testnet
Explorer URL: https://moonbase-blockscout.testnet.moonbeam.network/tx/0xb43184f219f3e32607ecf0527787d64c25c42ec46b407bcce6d4606ef861e7f9


### Contributing
Voronoi is an open project which welcomes contribution. Please send us a pull request in case you have a contribution.

### Licensing
Voronoi is Licensed under [Apache2](https://github.com/Qrucial/voronoi/blob/main/LICENSE)
