// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.12;

import "./Types.sol";

contract StubVerifier is IReclaimProofVerifier {
    function verifyProof(Proof memory proof) external view returns (bool) {
        return true;
    }
}
