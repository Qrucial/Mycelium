# Mycelium &middot; [![GitHub license](https://img.shields.io/badge/license-GPL3%2FApache2-blue)](https://github.com/Qrucial/mycelium/blob/main/LICENSE)
Mycelium | Making "decentralized" blockchain projects actually decentralized. 

### Assumption
Crypto project with decentralization as one of the core principle.

### Problem
The existence of (SPoF) single point of failures.

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


### Example Topology of a real decentralized smart contract
![Decentralized Organization](/images/DecentraLibExample.jpg)

### Contributing
Mycelium is an open project which welcomes contribution. Please send us a pull request in case you have a contribution.

### Licensing
Mycelium is Licensed under [Apache2](https://github.com/Qrucial/mycelium/blob/main/LICENSE)
