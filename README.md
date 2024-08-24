# ONI-CHAN 👦

For ETH-Tokyo 2024, we are proud to present **ONI-CHAN**, a fiat-to-crypto, over-the-counter protocol designed to be fast, and to eliminate the need for trust.

## What is ONI-CHAN?

ONI-CHAN is an innovative on-chain solution that addresses the trust issues commonly associated with traditional OTC trading.

By leveraging zero-knowledge proofs, the protocol ensures that users can securely and instantly claim from a smart contract the cryptocurrency they’ve purchased as soon as they deposit fiat money into a specified account, whether it's a bank account or a digital wallet like PayPal.

Fun fact: “Oni-chan” is an anagram of “onchain” -- a happy little accident that perfectly aligns with the protocol’s on-chain nature.

## What is OTC?

**Over-the-Counter (OTC)** trading refers to the direct exchange of assets between two parties without the involvement of a centralized exchange. OTC trading allows buyers and sellers to negotiate and execute trades privately, offering more flexibility, privacy, and control over the transaction terms.

## Why is OTC necessary?

- **True Decentralization**:
    OTC trading allows individuals to trade directly with one another, without relying on a centralized entity such as a cryptocurrency exchange.
- **Privacy and Anonymity**:
    OTC doesn’t require disclosing personal information to a third-party platform, which is common on exchanges.
- **Lower Fees**:
    Without the need for a centralized intermediary, OTC trades often have lower fees compared to the transaction and withdrawal fees charged by exchanges.
- **Regulatory Flexibility**:
    Depending on the jurisdiction, OTC trades may face less stringent regulatory requirements compared to centralized exchanges, which are often subject to heavy regulations.
- **Tailored Liquidity Solutions**:
    For large transactions, OTC trading can offer better liquidity solutions tailored to the specific needs of the buyer and seller, avoiding the market impact that might occur on exchanges.

## Traditional OTC Flow and Its Challenges

The traditional OTC trading process typically follows these steps:

1. **Trade Initiation**: The user initiates the trade.
2. **Fiat Transfer**: The user transfers fiat to a specified account.
3. **Fund Confirmation**: The seller confirms receipt of funds.
4. **Crypto Transfer**: The seller sends cryptocurrency to the user.
5. **Crypto Receipt**: The user receives the purchased cryptocurrency.

However, this method is fraught with potential issues:

**During Fund Confirmation**:

- **Delayed Response**: The seller may be slow in responding, causing unnecessary delays.
- **Overwhelmed Sellers**: The seller might be handling too many requests, leading to slow or missed transactions.
- **Transaction Bailout**: The seller could bail out on the transaction after the funds have been transferred, leaving the user in a precarious situation.
- **Scammers**: The seller may be a scammer, leaving the user at risk of losing their money.

**During Crypto Transfer**:

- **Incorrect Amount**: The seller might send the wrong amount of cryptocurrency.
- **Wrong Address**: The seller could mistakenly send the funds to an incorrect address.

## The Solution? Eliminating Uncertainty

Imagine a world where all this uncertainty is removed, and users can have peace of mind as soon as they’ve sent the funds. With ONI-CHAN, this vision becomes a reality, as it ensures that every step of the transaction is secure, automatic, and trustless, eliminating the risks associated with traditional OTC trading.

## Building the Perfect ONI-CHAN

ONI-CHAN leverages cutting-edge technology to create a secure, trustless environment for OTC trading, addressing the pain points of traditional methods. At the core of our protocol is the [Reclaim Protocol](https://www.reclaimprotocol.org/), which we have customized to integrate with [Mega Bank](https://en.wikipedia.org/wiki/Mega_International_Commercial_Bank)’s transfer history. This integration allows users to securely prove their bank transfer history and submit a zero-knowledge proof (zk proof) for smart contract verification.

### Using Reclaim Protocol

Reclaim Protocol is a decentralized data verification tool that ensures data integrity and privacy. It works by using a TLS proxy with selective disclosure and zk proof mechanisms. Here’s how it fits into ONI-CHAN:

1. **Custom Data Provider**: We have created a custom data provider using Reclaim Protocol, specifically designed to connect with Mega Bank. This allows users to retrieve their bank transfer history in a secure and private manner.

2. **Secure and Private Verification**: When a user initiates a transaction on ONI-CHAN, they can use Reclaim Protocol to generate a zk proof of their bank transfer history. This proof is cryptographically secured, ensuring that the user’s sensitive information, such as account numbers, remains private.

3. **Smart Contract Integration**: The zk proof generated by Reclaim Protocol is submitted to the ONI-CHAN smart contract for verification. Within the smart contract, sellers can create an order and deposit their cryptocurrency, specifying the conditions they want the buyer to prove, such as a bank transfer to a specific account or a PayPal transfer to a particular email address.

By integrating Reclaim Protocol, ONI-CHAN ensures that each step of the OTC transaction is secure and trustless. Users can rest assured that once they submit their payment, the verification process is automatic, eliminating the delays and uncertainties associated with traditional OTC trading.

## Deployment

### Scroll Sepolia Contract Addresses

| Contract      | Address                                                                                                                      |
|---------------|------------------------------------------------------------------------------------------------------------------------------|
| Fiat on ramp  | [0xd570bf4598d3ccf214e288dd92222b8bd3134984](https://sepolia.scrollscan.com/address/0xd570bf4598d3ccf214e288dd92222b8bd3134984) |
| USDT          | 0xB06c44B2601AB296269dDC081492B266C49C6949                                                                                   |
| USDC          | 0x7356f4cC77168d0e6f94F1d8E28aeA1316852c0d                                                                                   |

### Linea Sepolia Contract Addresses

| Contract      | Address                                                                                                                      |
|---------------|------------------------------------------------------------------------------------------------------------------------------|
| Fiat on ramp  | [0x8b3340EFcB90e586Edf0790538c7f3730560D4b3](https://sepolia.lineascan.build/address/0x8b3340efcb90e586edf0790538c7f3730560d4b3) |
| USDT          | 0xD570bF4598D3ccF214E288dd92222b8Bd3134984                                                                                   |
| USDC          | 0xB06c44B2601AB296269dDC081492B266C49C6949                                                                                   |

### Nero Chain Contract Addresses

| Contract      | Address                                                                                                                      |
|---------------|------------------------------------------------------------------------------------------------------------------------------|
| Fiat on ramp  | [0x8b3340EFcB90e586Edf0790538c7f3730560D4b3](https://testnetscan.nerochain.io/address/0x8b3340EFcB90e586Edf0790538c7f3730560D4b3) |
| USDT          | 0xD570bF4598D3ccF214E288dd92222b8Bd3134984                                                                                   |
| USDC          | 0xB06c44B2601AB296269dDC081492B266C49C6949                                                                                   |

## Challenges

The first major hurdle we faced was defining the schema for the data retrieved from Mega Bank. The bank’s response format was not straightforward, which led to several rounds of trial and error in defining the correct schema that could be parsed and used by Reclaim Protocol.

Another challenge was the reliability of proof generation and submission. Reclaim Protocol requires specific tokens or cookies to generate proofs for bank related requests, but these elements were not always present or properly handled in the bank’s responses. This led to intermittent failures in proof generation, which in turn caused delays and frustration during development.

The instability of Reclaim Protocol itself compounded these issues. As a relatively new and evolving protocol, it isn't always stable or predictable. This meant that even when our schema and token management were correct, we still faced occasional failures due to the underlying protocol.

## Learnings

We learned how Reclaim Protocol works to securely pull and verify sensitive data, such as bank transfer history, without exposing the actual details. The protocol’s ability to generate zero-knowledge proofs allows us to ensure the authenticity of the data while maintaining user privacy.

## Potential Next Steps

- Support for More Banks and Payment Methods
- Support for More Fiat Currencies
- Enhance User Experience
- Cross-Chain Compatibility
- Decentralization of Reclaim Protocol Nodes
