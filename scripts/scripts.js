const {ethers}= require("ethers")
const provider = new ethers.providers.JsonRpcProvider("https://polygon-mumbai.g.alchemy.com/v2/I_qu-j_NdqowJJXi3zJcUQPe6z4Yf9id")
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
// const wallet2= new ethers.Wallet(process.env.PRIVATE_KEY2,provider);
const owner="0x0c5719DE71d34B4ecaf12AaddaB355e993F789D3"

// const contractAddress = "0xe600B0951651d90cC8597426d576d0edB7E00D43"
const ContractAddress = "0xa8FDABfCe0d8a3F594d0277e7fD5346cC9C732b7"

const ABI = require("../artifacts/contracts/Lending.sol/Lending.json")
const ERC20ABI= require("../artifacts/@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol/IERC20.json")

const linkAddress = "0x4e2f1E0dC4EAD962d3c3014e582d974b3cedF743";
const alinkAddress = "0x60f42c880B61D9114251882fC144395843D9839d";
const DaiAddress="0xF14f9596430931E177469715c591513308244e8F";
const AavePolDebtStableDai="0x7df8918f0DA9a9FB286E3dA272C33645b6812582";

const LINK = new ethers.Contract(linkAddress,ERC20ABI.abi,wallet)
const ALINK = new ethers.Contract(alinkAddress,ERC20ABI.abi,wallet)
const DAI = new ethers.Contract(DaiAddress,ERC20ABI.abi,wallet)

const contract = new ethers.Contract(ContractAddress,ABI.abi,provider)
const contract_rw = new ethers.Contract(ContractAddress,ABI.abi,wallet)
const getpoolAddress = async(req,res)=>{
	const PoolAddress = await contract_rw.POOL()
    res.send(PoolAddress)
	
}
const Lend = async (req,res)=> {

    let TokenAddress = req.body.TokenAddress ;
    let amount = req.body.amount;
	
	// let  gas = await contract_rw.estimateGas.supplyLiquidity(asset,amount);
	// let  gas1 = await IERC20.estimateGas.transfer(ContractAddress,amount);
	// let  gas2 = await IERC20.estimateGas.approve(PoolAddress,amount);
	// console.log("Abc")
	const PoolAddress = await contract.POOL()
	// console.log(PoolAddress)
	
	await LINK.transfer(ContractAddress,amount)
	// console.log("hello")
	await contract_rw.approveLINK(amount,PoolAddress)
	// console.log("hello1")
	// let  gas = await contract_rw.estimateGas.supplyLiquidity(asset,amount);
    const tx = await contract_rw.supplyLiquidity(TokenAddress,amount)
    const txhash = await provider.waitForTransaction(tx.hash)
    // console.log(tx1)
    res.send(`Transaction Hash : ${txhash.transactionHash}
                From : ${txhash.from}`)
    // console.log(txhash)
	// console.log("lend Completed")
    // console.log(txhash.transactionHash)

}
const withdraw = async (req,res)=> {

    let TokenAddress = req.body.TokenAddress ;
    let amount = req.body.amount;
	await ALINK.transfer(ContractAddress,amount)
    // const tx1= await  contract_rw.approve(AuctioncontractAddress,1)
    const tx = await contract_rw.withdrawlLiquidity(TokenAddress,amount)
    const txhash = await provider.waitForTransaction(tx.hash)
    // console.log(tx1)
    // console.log(txhash.transactionHash)
    res.send(`Transaction Hash : ${txhash.transactionHash}
                From : ${txhash.from}`)
    // console.log(txhash)

}
const borrow = async (req,res)=> {

    let TokenAddress = req.body.TokenAddress ;
    let amount = req.body.amount;
    let interestRateMode = req.body.interestRateMode;
    console.log("a")
	await ALINK.transfer(ContractAddress,50000000000)
    // const tx1= await  contract_rw.approve(AuctioncontractAddress,1)
	console.log("b")
    const tx = await contract_rw.borrowLiquidity(TokenAddress,amount,interestRateMode)
    const txhash = await provider.waitForTransaction(tx.hash)
    // console.log(tx1)
    res.send(`Transaction Hash : ${txhash.transactionHash}
                From : ${txhash.from}`)
    // console.log(txhash)


}
const repay = async(req,res)=>{
	let TokenAddress = req.body.TokenAddress ;
    let amount = DAI.balanceOf(ContractAddress);
    let interestRateMode = req.body.interestRateMode;
	const PoolAddress = await contract.POOL()
	await DAI.transfer(ContractAddress,100000000000)
	await contract_rw.approveDAI(amount,PoolAddress)
	console.log("approveddddd")
    // const tx1= await  contract_rw.approve(AuctioncontractAddress,1)
    const tx = await contract_rw.repayLiquidity(TokenAddress,amount,interestRateMode)
    const txhash = await provider.waitForTransaction(tx.hash)
    // console.log(tx1)
    res.send(`Transaction Hash : ${txhash.transactionHash}
                From : ${txhash.from}`)
}
const GetInfo = async(req,res)=>{
	let userAddress = req.body.address;
    console.log(userAddress)
    // const tx1= await  contract_rw.approve(AuctioncontractAddress,1)
    const tx = await contract_rw.getUserAccountData(userAddress)
    //  console.log((tx.totalCollateralBase).toString())
    res.send(`totalCollateralBase: ${tx.totalCollateralBase.toString()}
            totalDebtBase:${tx.totalDebtBase.toString()}
            availableBorrowsBasee:${tx.availableBorrowsBase.toString()}
            currentLiquidationThreshold:${tx.currentLiquidationThreshold.toString()}
            ltv:${tx.ltv.toString()}
            healthFactor:${tx.healthFactor.toString()}`)
     
}
 const GetBalanceLender = async(req,res)=>{
    let TokenAddress = req.body.TokenAddress
	const tx = await contract_rw.getBalanceLender(TokenAddress)
	res.send(`LenderBalance: ${tx.toString()}`)

 }
 const GetBalanceContract= async(req,res)=>{
    let TokenAddress = req.body.TokenAddress
	const tx = await contract_rw.getBalanceContract(TokenAddress)
    res.send(`ContractBalance: ${tx.toString()}`)
 }
 const withdrawFromContract = async(req,res)=>{
	let TokenAddress = req.body.TokenAddress;
	// let tokenAddress=alinkAddress;
	// let tokenAddress=DaiAddress;
	const tx = await contract_rw.withdraw(TokenAddress)
    const txhash = await provider.waitForTransaction(tx.hash)
    res.send(`Transaction Hash : ${txhash.transactionHash}`)
 }


module.exports ={Lend,repay,getpoolAddress,withdraw,withdrawFromContract,GetBalanceContract,GetBalanceLender,GetInfo,borrow}






