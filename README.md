# 🏗  MyDex


# 🏄‍♂️ Quick Start

Prerequisites: [Node (v16 LTS)](https://nodejs.org/en/download/) plus [Yarn](https://classic.yarnpkg.com/en/docs/install/) and [Git](https://git-scm.com/downloads)

> clone/fork 🏗 scaffold-eth:

```bash
git clone https://github.com/kevin-ksis/....git
```

> install and start your 👷‍ Hardhat chain:

```bash
yarn install
yarn chain
```

> in a second terminal window, start your 📱 frontend:

```bash
yarn start
```

> in a third terminal window, 🛰 deploy your contract:

```bash
yarn deploy
```

📱 Open http://localhost:3000 to see the app

# 💌 P.S.

🌍 You need an RPC key for testnets and production deployments, create an [Alchemy](https://www.alchemy.com/) account and replace the value of `ALCHEMY_KEY = xxx` in `packages/react-app/src/constants.js` with your new key.

📣 Make sure you update the `InfuraID` before you go to production. Huge thanks to [Infura](https://infura.io/) for our special account that fields 7m req/day!

# Stack

> Following TraderJoeXYZ.com

# The concepts
- *Underlying tokens:* The token is a base token of liquidity token.  
- *Liquidity provider*: provide the pool with the two tokens that can be exchanged (we'll call them **Token0** and **Token1**). In return, they receive a third token that represents partial ownership of the pool called a *liquidity token.*  
- *Traders*: send one type of token to the pool and receive the other (for example, send **Token0**
 and receive **Token1**) out of the pool provided by the liquidity providers.  
- *Add liquidity*:  
    - 👳‍♀️ Caller:  
        - Provide an allowance in the amounts of the token to be added to the liquidity pool  
        - Call router contract's addLiquidity functions  
    - ✡️ Router contract  
        - Create a pair exchange if necessary  
        - If there is an existing pair exchange, calculate the amount of token to add  
        - Check if the amounts are accepted  
        - Call pair contract  
    - 👥 Pair contract  
        - Mint liquidity tokens and send them to the caller  
        - Call _update to update the reverse amount  
- *Remove liquidity*  
    - 👳‍♀️ Caller:  
        - Provide an allowance of liquidity tokens to be burned in the exchange  
        - Call Router contract's removeLiquidity functions  
    - ✡️ Router contract  
        - Send the liquidity tokens to the pair exchange  
    - 👥 Pair contract  
        - Send underlying tokens in proportion to the destination address.  
        - Burn the liquidity tokens  
        - Call _update to update the reverse amount  
- *abi.encodeWithSelector && abi.encode && abi.encodePacked && abi.encodeWithSignature*  
    - [https://medium.com/@libertylocked/what-are-abi-encoding-functions-in-solidity-0-4-24-c1a90b5ddce8](https://medium.com/@libertylocked/what-are-abi-encoding-functions-in-solidity-0-4-24-c1a90b5ddce8)  
- Domain separator:  
    - The domain separator prevents collision of otherwise identical structures. It is possible that two DApps come up with an identical structure like Transfer(address from,address to,uint256 amount) that should not be compatible. By introducing a domain separator the DApp developers are guaranteed that there can be no signature collision.  
    - [https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md)  
- MASK - new restriction from version 0.8.0  
    - uint256 public constant MASK = type(uint128).max;  
    - [https://docs.soliditylang.org/en/breaking/080-breaking-changes.html#new-restrictions](https://docs.soliditylang.org/en/breaking/080-breaking-changes.html#new-restrictions)  