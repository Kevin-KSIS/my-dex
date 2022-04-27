// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <=0.8.4;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "./KevPair.sol";

contract KevFactory is IUniswapV2Factory {

    address public override feeToSetter;
    address public override feeTo;
    address[] public override allPairs;
    mapping(address => mapping(address => address)) public override getPair;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);
  
    constructor(address _feeToSetter){
        feeToSetter = _feeToSetter;
    }
    

    function _sortTokens(address tokenA, address tokenB) pure internal returns (address token0, address token1) {
        if (tokenA < tokenB) {
            token0 = tokenA;
            token1 = tokenB;
        }else {
            token0 = tokenB;
            token1 = tokenA;
        }
    }

    /**
     * @notice Create a pair of two tokens and return the address of the pair
    */
    function createPair(address tokenA, address tokenB) override external returns (address pair){
        require(tokenA != address(0), "Not a null address");
        require(tokenA != tokenB, "Providing difference tokens");

        // Sorting
        (address _token0, address _token1) = _sortTokens(tokenA, tokenB);
        require(getPair[_token0][_token1] == address(0), "The pool is exists");

        // Call a contract of pair using opcode to save gas fee;
        bytes memory _bytecodeOfKevPair = type(KevPair).creationCode; // similar call a contract with an address
        bytes32 _salt = keccak256(abi.encodePacked(_token0, _token1)); // Encoding parameters of KevPair
        assembly {
            pair := create2(0, add(_bytecodeOfKevPair, 32), mload(_bytecodeOfKevPair), _salt) // ? Do you understand it?
        }

        KevPair(pair).initialize(_token0, _token1);
        getPair[_token0][_token1] = pair;
        getPair[_token1][_token0] = pair;
        allPairs.push(pair);

        emit PairCreated(_token0, _token1, pair, allPairs.length);
    }


    function allPairsLength() override external view returns (uint){
        return allPairs.length;
    }

    /**
    * @notice Update the address that is received transaction fees
    */
    function setFeeTo(address _newFeeTo) override  external{
        require(msg.sender == feeToSetter, "Permission denied");
        feeTo = _newFeeTo;
    }

    /**
    * @notice Update the address that allow set who is received transaction fees
    */
    function setFeeToSetter(address _newSetter) override external{
        require(msg.sender == feeToSetter, "Permission denied");
        feeToSetter = _newSetter;
    }

}
