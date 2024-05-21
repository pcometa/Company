// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract Company{
    address public owner;
    address public head;
    uint256 public totalAmountEntered=0;
    uint256 public ownerPercent=500;
    uint256 public headPercent=500;
    uint256 public ownerTotalAmountWithdrawn;
    uint256 public headTotalAmountWithdrawn;
    IERC20 public token;
    enum accessibleFunctions{
        addLiquidity
    }

    mapping(address=>mapping (uint8 => bool))public operators;
    constructor(address _token){
        owner=msg.sender;
        token=IERC20(_token);
    }

    modifier onlyOwnerAndOperators(uint8 _accessibleFunctionsId){
        if(msg.sender==owner || operators[msg.sender][_accessibleFunctionsId]){
            _;
        }
        else{
            revert("You are not the owner of the contract or you don't have access to call this function");
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of the contract");
        _;
    }

    function withdraw(uint256 _amount)public{
        if(msg.sender==owner){
            uint256 withdrawableAmount=((totalAmountEntered*ownerPercent)/1000)-ownerTotalAmountWithdrawn;
            require(withdrawableAmount>=_amount,"You don't have this amount to withdraw");
            require(token.balanceOf(address(this))>=_amount,"The balance of the contract is not enough");
            require(token.transfer(msg.sender, _amount),"Transaction failed");
            ownerTotalAmountWithdrawn+=_amount;
        }
        else if(msg.sender==head){
            uint256 withdrawableAmount=((totalAmountEntered*headPercent)/1000)-headTotalAmountWithdrawn;
            require(withdrawableAmount>=_amount,"You don't have this amount to withdraw");
            require(token.balanceOf(address(this))>=_amount,"The balance of the contract is not enough");
            require(token.transfer(msg.sender, _amount),"Transaction failed");
            headTotalAmountWithdrawn+=_amount;
        }
        else{
            revert("This function can only call by owner or head");
        }
        
    }

    function addOperator(address _operator,uint8 _accessibleFunctionsId)public onlyOwner(){
        require(!operators[_operator][_accessibleFunctionsId],"operator is already added");
        operators[_operator][_accessibleFunctionsId]=true;
    }

    function removeOperator(address _operator,uint8 _accessibleFunctionsId)public onlyOwner(){
        require(operators[_operator][_accessibleFunctionsId],"operator not found");
        delete operators[_operator][_accessibleFunctionsId];
    }

    function addLiquidity(uint256 _amount)public onlyOwnerAndOperators(0){
        totalAmountEntered= totalAmountEntered+_amount;
    }

    function setHeadAddress(address _head)public onlyOwner(){
        head=_head;
    }

    function setPercents(uint256 _ownerPercent,uint256 _headPercent)public onlyOwner(){
        ownerPercent=_ownerPercent;
        headPercent=_headPercent;
    }
}