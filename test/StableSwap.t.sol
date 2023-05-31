// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import "forge-std/Test.sol";
import { console } from "forge-std/console.sol";
import "../src/StableSwap.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract StableSwapTest is Test {
    ERC20[] tokens;
    StableSwap stableSwap;

    function setUp() public {
        tokens = new ERC20[](3);
        tokens[0] = new MockERC20("DAI", "DAI", 18);
        tokens[1] = new MockERC20("USDC", "USDC", 6);
        tokens[2] = new MockERC20("USDT", "USDT", 6);
        stableSwap = new StableSwap(tokens);
        console.log(stableSwap.tokens(0));

        uint256[3] memory addTokens = [uint256(10000 * 1e18), uint256(10000 * 1e6), uint256(10000 * 1e6)];
        for (uint i; i < 3; ++i) {
            tokens[i].approve(address(stableSwap), type(uint256).max);
        }
        stableSwap.addLiquidity(addTokens, 0);
        console.log("balance", tokens[2].balanceOf(address(this)));
    }

    function test1() public {
        uint256 y1 = stableSwap.swap(1,2, 1000 * 1e6, 0);
        uint256 y2 = stableSwap.swap(1,2, 1000 * 1e6, 0);
        uint256 y3 = stableSwap.swap(1,2, 1000 * 1e6, 0);
        uint256 y4 = stableSwap.swap(1,2, 1000 * 1e6, 0);
        uint256 y5 = stableSwap.swap(1,2, 1000 * 1e6, 0);
        assertTrue(false);
    }

    function test_exchange() public {
        for (uint i; i < 15; ++i) {
            uint256 y = stableSwap.swap(1,2, 1000 * 1e6, 0);
        }

        // stableSwap.swap(1,2, 15000 * 1e6, 0);
        uint256 p = stableSwap.getVirtualPrice();
        console.log("p", p);
        console.log("balance", tokens[2].balanceOf(address(this)));
        assertTrue(false);
    }
}

contract MockERC20 is ERC20 {
    uint8 _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_, symbol_) {
        _decimals = decimals_;
        _mint(msg.sender, 100000 * (10 ** decimals()));
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
}

