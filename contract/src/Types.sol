// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.12;

struct SellOrder {
    uint256 orderId;
    address from;
    address token;
    uint256 amount;
    uint256 conditionHash;
}

struct CompleteClaimData {
    bytes32 identifier;
    address owner;
    uint32 timestampS;
    uint32 epoch;
}

struct ClaimInfo {
    string provider;
    string parameters;
    string context;
}

/** Claim with signatures & signer */
struct SignedClaim {
    CompleteClaimData claim;
    bytes[] signatures;
}

struct Proof {
    ClaimInfo claimInfo;
    SignedClaim signedClaim;
}

interface IReclaimProofVerifier {
    function verifyProof(Proof memory proof) external view returns (bool);
}
