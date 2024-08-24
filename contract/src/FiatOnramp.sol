// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./Types.sol";

contract FiatOnramp {
    using SafeERC20 for IERC20;

    IReclaimProofVerifier public immutable reclaimProofVerifier;

    mapping(address => SellOrder) public orders;

    event OrderCreated(
        address indexed from,
        address indexed token,
        uint256 amount,
        uint256 conditionHash
    );
    event OrderFilled(
        address indexed from,
        address indexed token,
        uint256 amount,
        uint256 conditionHash
    );

    constructor(address _reclaimProofVerifier) {
        reclaimProofVerifier = IReclaimProofVerifier(_reclaimProofVerifier);
    }

    function createOrder(
        address _token,
        uint256 _amount,
        uint256 _conditionHash
    ) external {
        _createOrder(_token, _amount, _conditionHash);
    }

    function _createOrder(
        address _token,
        uint256 _amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        IERC20Permit(_token).permit(
            msg.sender,
            address(this),
            _amount,
            deadline,
            v,
            r,
            s
        );
        _createOrder(_token, _amount, _conditionHash);
    }

    function _createOrder(
        address _token,
        uint256 _amount,
        uint256 _conditionHash
    ) internal {
        require(
            orders[msg.sender].from == address(0),
            "FiatOnramp: order already exists"
        );
        require(_token != address(0), "FiatOnramp: invalid token");
        require(_amount > 0, "FiatOnramp: amount must be greater than 0");
        IERC20(_token).safeTransferFrom(msg.sender, address(this), _amount);

        SellOrder memory order = SellOrder({
            from: msg.sender,
            token: _token,
            amount: _amount,
            conditionHash: _conditionHash
        });
        orders[msg.sender] = order;
        emit OrderCreated(msg.sender, _token, _amount, _conditionHash);
    }

    function fillOrder(
        address _from,
        Proof memory proof,
        uint256 _conditionHash
    ) external {
        SellOrder memory order = orders[_from];
        require(order.from != address(0), "FiatOnramp: order does not exist");
        require(
            order.conditionHash == _conditionHash,
            "FiatOnramp: invalid condition hash"
        );
        IERC20(order.token).safeTransfer(msg.sender, order.amount);
        delete orders[_from];
        emit OrderFilled(_from, order.token, order.amount, _conditionHash);
    }

    receive() external payable {}
}