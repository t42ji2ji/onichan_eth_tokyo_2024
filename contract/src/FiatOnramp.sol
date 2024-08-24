// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./Types.sol";

contract FiatOnramp {
    using SafeERC20 for IERC20;

    IReclaimProofVerifier public immutable reclaimProofVerifier;

    mapping(uint256 => SellOrder) public orders;

    uint256 public nextOrderId;
    uint256 public activeOrderCount;

    event OrderCreated(
        uint256 indexed orderId,
        address indexed from,
        address indexed token,
        uint256 amount,
        uint256 conditionHash
    );
    event OrderFilled(
        uint256 indexed orderId,
        address indexed from,
        address indexed token,
        uint256 amount,
        uint256 conditionHash
    );

    constructor(address _reclaimProofVerifier) {
        reclaimProofVerifier = IReclaimProofVerifier(_reclaimProofVerifier);
        nextOrderId = 1;
        activeOrderCount = 0;
    }

    receive() external payable {}

    function createOrder(
        address _token,
        uint256 _amount,
        uint256 _conditionHash
    ) external {
        _createOrder(_token, _amount, _conditionHash);
    }

    function allOrders() external view returns (SellOrder[] memory) {
        SellOrder[] memory _orders = new SellOrder[](activeOrderCount);
        uint256 index = 0;
        for (uint256 i = 1; i < nextOrderId; i++) {
            if (orders[i].from != address(0)) {
                _orders[index] = orders[i];
                index++;
            }
        }
        return _orders;
    }

    function _createOrder(
        address _token,
        uint256 _amount,
        uint256 _conditionHash,
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
        require(_token != address(0), "FiatOnramp: invalid token");
        require(_amount > 0, "FiatOnramp: amount must be greater than 0");
        IERC20(_token).safeTransferFrom(msg.sender, address(this), _amount);

        SellOrder memory order = SellOrder({
            orderId: nextOrderId,
            from: msg.sender,
            token: _token,
            amount: _amount,
            conditionHash: _conditionHash
        });
        orders[nextOrderId] = order;
        emit OrderCreated(
            nextOrderId,
            msg.sender,
            _token,
            _amount,
            _conditionHash
        );
        nextOrderId++;
        activeOrderCount++;
    }

    function fillOrder(
        uint256 _orderId,
        Proof memory proof,
        uint256 _conditionHash
    ) external {
        SellOrder memory order = orders[_orderId];
        require(order.from != address(0), "FiatOnramp: order does not exist");
        require(
            order.conditionHash == _conditionHash,
            "FiatOnramp: invalid condition hash"
        );
        require(
            reclaimProofVerifier.verifyProof(proof),
            "FiatOnramp: invalid proof"
        );

        delete orders[_orderId];
        activeOrderCount--;

        IERC20(order.token).safeTransfer(msg.sender, order.amount);

        emit OrderFilled(
            _orderId,
            order.from,
            order.token,
            order.amount,
            _conditionHash
        );
    }
}
