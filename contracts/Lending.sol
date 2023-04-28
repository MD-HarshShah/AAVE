 // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
// import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
// import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

// contract Lending{
//     address payable owner;

//     IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
//     IPool public immutable POOL;
//     // 0xeb7A892BB04A8f836bDEeBbf60897A7Af1Bf5d7F polygon pool address provider
//     address private immutable linkAddress = 0x4e2f1E0dC4EAD962d3c3014e582d974b3cedF743;
//     address private immutable alinkAddress = 0x60f42c880B61D9114251882fC144395843D9839d;

//     IERC20 private link;
//     IERC20 private alink;
//     // address public  Address = 0x0c5719DE71d34B4ecaf12AaddaB355e993F789D3 ;

//     constructor(address _addressProvider) {
//         ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
//         POOL = IPool(ADDRESSES_PROVIDER.getPool());
//         owner = payable(msg.sender);
//         link = IERC20(linkAddress);
//         alink = IERC20(alinkAddress);
//     }

//     function supplyLiquidity(address _tokenAddress, uint256 _amount) external {
//         address asset = _tokenAddress;
//         uint256 amount = _amount;
//         address onBehalfOf = msg.sender ;
//         uint16 referralCode = 0;

//         POOL.supply(asset, amount, onBehalfOf, referralCode);
//     }

//     function withdrawlLiquidity(address _tokenAddress, uint256 _amount)
//         external
//         returns (uint256)
//     {
//         address asset = _tokenAddress;
//         uint256 amount = _amount;
//         address to = msg.sender;

//         return POOL.withdraw(asset, amount, to);
//     }

//     function borrowLiquidity(address _tokenAddress,uint256 _amount,uint256 _interestRateMode) 
//         external
//         {
//         address asset = _tokenAddress;
//         uint256 amount = _amount;
//         uint interestRateMode = _interestRateMode;
//         uint16 referralCode = 0;
//         address onBehalfOf = 0x93a9071BFBeaBe2305B8D91E4aA31dDdaD59aE02;

//         POOL.borrow(asset, amount, interestRateMode,referralCode,onBehalfOf);

//     }

//     function repayLiquidity(
//     address _tokenAddress,
//     uint256 _amount,
//     uint256 _interestRateMode
//   ) external returns (uint256){
//         address asset = _tokenAddress;
//         uint256 amount = _amount;
//         uint interestRateMode = _interestRateMode;
//         address onBehalfOf = msg.sender;
        
//         return POOL.repay(asset, amount, interestRateMode,onBehalfOf);
//   }
    
//     function getUserAccountData(address _userAddress)
//         external
//         view
//         returns (
//             uint256 totalCollateralBase,
//             uint256 totalDebtBase,
//             uint256 availableBorrowsBase,
//             uint256 currentLiquidationThreshold,
//             uint256 ltv,
//             uint256 healthFactor
//         )
//     {
//         return POOL.getUserAccountData(_userAddress);
//     }

//     function approveLINK(uint256 _amount, address _poolContractAddress)
//         external
//         returns (bool)
//     {
//         return link.approve(_poolContractAddress, _amount);
//     }

//     function allowanceLINK(address _poolContractAddress)
//         external
//         view
//         returns (uint256)
//     {
//         return link.allowance(msg.sender, _poolContractAddress);
//     }

//     function approveALINK(uint256 _amount, address _poolContractAddress)
//         external
//         returns (bool)
//     {
//         return alink.approve(_poolContractAddress, _amount);
//     }

//     function allowanceALINK(address _poolContractAddress)
//         external
//         view
//         returns (uint256)
//     {
//         return alink.allowance(msg.sender, _poolContractAddress);
//     }


//     function getBalanceLender(address _tokenAddress) external view returns (uint256) {
//         return IERC20(_tokenAddress).balanceOf(msg.sender);
//     }
//     function getBalanceContract(address _tokenAddress) external view returns (uint256) {
//         return IERC20(_tokenAddress).balanceOf(msg.sender);
//     }

//     // function withdraw(address _tokenAddress) external onlyOwner {
//     //     IERC20 token = IERC20(_tokenAddress);
//     //     token.transfer(msg.sender, token.balanceOf(msg.sender));
//     // }

//     modifier onlyOwner() {
//         require(
//             msg.sender == owner,
//             "Only the contract owner can call this function"
//         );
//         _;
//     }

//     receive() external payable {}
// }
pragma solidity ^0.8.9;

import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract Lending{
    address payable owner;

    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;
    // 0xeb7A892BB04A8f836bDEeBbf60897A7Af1Bf5d7F polygon pool address provider
    address private immutable linkAddress = 0x4e2f1E0dC4EAD962d3c3014e582d974b3cedF743;
    address private immutable alinkAddress = 0x60f42c880B61D9114251882fC144395843D9839d;
    address private immutable daiAddress= 0xF14f9596430931E177469715c591513308244e8F;

    IERC20 public  link;
    IERC20 public alink;
    IERC20 public dai;
    // address public  Address = 0x0c5719DE71d34B4ecaf12AaddaB355e993F789D3 ;

    constructor(address _addressProvider) {
        ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
        POOL = IPool(ADDRESSES_PROVIDER.getPool());
        owner = payable(msg.sender);
        link = IERC20(linkAddress);
        alink = IERC20(alinkAddress);
        dai = IERC20(daiAddress);
    }

    function supplyLiquidity(address _tokenAddress, uint256 _amount) external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address onBehalfOf = msg.sender ;
        uint16 referralCode = 0;

        POOL.supply(asset, amount, onBehalfOf, referralCode);
    }

    function withdrawlLiquidity(address _tokenAddress, uint256 _amount)
        external
        returns (uint256)
    {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address to = msg.sender;
        return POOL.withdraw(asset, amount, to);
    }

    function borrowLiquidity(address _tokenAddress,uint256 _amount,uint256 _interestRateMode) 
        external
        {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        uint interestRateMode = _interestRateMode;
        uint16 referralCode = 0;
        address onBehalfOf = address(this);

        POOL.borrow(asset, amount, interestRateMode,referralCode,onBehalfOf);

    }

    function repayLiquidity(
    address _tokenAddress,
    uint256 _amount,
    uint256 _interestRateMode
  ) external returns (uint256){
        address asset = _tokenAddress;
        uint256 amount = _amount;
        uint interestRateMode = _interestRateMode;
        address onBehalfOf = address(this);
        
        return POOL.repay(asset, amount, interestRateMode,onBehalfOf);
  }
    
    function getUserAccountData(address _userAddress)
        external
        view
        returns (
            uint256 totalCollateralBase,
            uint256 totalDebtBase,
            uint256 availableBorrowsBase,
            uint256 currentLiquidationThreshold,
            uint256 ltv,
            uint256 healthFactor
        )
    {
        return POOL.getUserAccountData(_userAddress);
    }

    function approveLINK(uint256 _amount, address _poolContractAddress)
        external
        returns (bool)
    {
        return link.approve(_poolContractAddress, _amount);
    }
    function approveDAI(uint256 _amount, address _poolContractAddress)
        external
        returns (bool)
    {
        return dai.approve(_poolContractAddress, _amount);
    }
    // function Transfer(address _tokenAddress,address _receiver,uint256 _amount)
    //     external
    // {
    //  IERC20(_tokenAddress).approve(_receiver,_amount);   
    //  IERC20(_tokenAddress).transferFrom(msg.sender,_receiver,_amount);
    // }

    function allowanceLINK(address _poolContractAddress)
        external
        view
        returns (uint256)
    {
        return link.allowance(address(this), _poolContractAddress);
    }

    function approveALINK(uint256 _amount, address _poolContractAddress)
        external
        returns (bool)
    {
        return alink.approve(_poolContractAddress, _amount);
    }

    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    function allowanceALINK(address _poolContractAddress)
        external
        view
        returns (uint256)
    {
        return alink.allowance(address(this), _poolContractAddress);
    }


    function getBalanceLender(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(msg.sender);
    }
    function getBalanceContract(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    // function withdraw(address _tokenAddress) external onlyOwner {
    //     IERC20 token = IERC20(_tokenAddress);
    //     token.transfer(msg.sender, token.balanceOf(msg.sender));
    // }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _;
    }

    receive() external payable {}
}