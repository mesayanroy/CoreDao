// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WillChain {
    address public owner;
    address public executor;
    bool public isDeceased;

    struct Beneficiary {
        address wallet;
        uint256 amount;
    }

    Beneficiary[] public beneficiaries;
    mapping(address => uint256) public inheritance;

    event FundsDistributed(address beneficiary, uint256 amount);
    event DeathConfirmed();
    event BeneficiaryAdded(address beneficiary, uint256 amount);
    event ExecutorChanged(address newExecutor);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyExecutor() {
        require(msg.sender == executor, "Not the executor");
        _;
    }

    modifier onlyIfDeceased() {
        require(isDeceased, "Owner is not deceased");
        _;
    }

    constructor(address _executor) payable {
        owner = msg.sender;
        executor = _executor;
    }

    receive() external payable {}

    function setExecutor(address _newExecutor) external onlyOwner {
        executor = _newExecutor;
        emit ExecutorChanged(_newExecutor);
    }

    function addBeneficiary(address _wallet, uint256 _amount) external onlyOwner {
        beneficiaries.push(Beneficiary(_wallet, _amount));
        inheritance[_wallet] = _amount;
        emit BeneficiaryAdded(_wallet, _amount);
    }

    function confirmDeath() external onlyExecutor {
        isDeceased = true;
        emit DeathConfirmed();
        distributeFunds();
    }

    function distributeFunds() internal onlyIfDeceased {
        for (uint256 i = 0; i < beneficiaries.length; i++) {
            address payable wallet = payable(beneficiaries[i].wallet);
            uint256 amount = inheritance[wallet];
            require(address(this).balance >= amount, "Insufficient contract balance");
            wallet.transfer(amount);
            emit FundsDistributed(wallet, amount);
        }
    }

    function getBeneficiaries() external view returns (Beneficiary[] memory) {
        return beneficiaries;
    }

    function emergencyWithdraw() external onlyOwner {
        require(!isDeceased, "Cannot withdraw after death");
        payable(owner).transfer(address(this).balance);
    }
}