// SPDX-License-Identifier: MIT
pragma solidity <=0.8.4;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract KevERC20 { // implement IUniswapV2ERC20

    using SafeMath for uint;

    string public constant name = "Kev LP Token";
    string public constant symbol = "Kev-LP";
    uint8 public constant decimals = 18;
    uint public totalSupply;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    /** @notice Following EIP712
     * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md
     */
    bytes32 public DOMAIN_SEPARATOR;
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    mapping(address => uint) public nonces;
    /** New restriction from v0.8.0
     * https://docs.soliditylang.org/en/breaking/080-breaking-changes.html#new-restrictions
     */
    uint public constant MASK = type(uint128).max;

    // ==== EVENTS
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    // ==== INTERNAL FUNCTIONS
    function _mint(address to, uint value) internal {
        totalSupply = totalSupply.add(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(address(0), to, value);
    }

    function _burn(address from, uint value) internal {
        balanceOf[from] = balanceOf[from].sub(value);
        totalSupply = totalSupply.sub(value);
        emit Transfer(from, address(0), value);
    }

    function _approve(address owner, address spender, uint value) private {
        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _transfer(address from, address to, uint value) private {
        balanceOf[from] = balanceOf[from].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(from, to, value);
    }

    // ==== EXTERNAL FUNCTIONS

    function approve(address spender, uint value) external  returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transfer(address to, uint value) external  returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) external  returns (bool) {
        if (allowance[from][msg.sender] != MASK) {
            // Must check overflow and underflow. Unless, an user can call transfer without approve
            allowance[from][msg.sender] = allowance[from][msg.sender].sub(value);
        }
        _transfer(from, to, value);
        return true;
    }

    /** @notice Permit approve for spender
     * Check signature to detect the deadline of action
     */
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        require(deadline >= block.timestamp, "Kev: EXPIRED");
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonces[owner]++, deadline))
            )
        );
        address recoveredAddress = ecrecover(digest, v, r, s);
        require(recoveredAddress != address(0) && recoveredAddress == owner, "Kev: INVALID_SIGNATURE");
        _approve(owner, spender, value);
    }

}