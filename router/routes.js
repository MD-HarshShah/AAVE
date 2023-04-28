const express = require("express")
const {Lend,repay,getpoolAddress,withdraw,withdrawFromContract,GetBalanceContract,GetBalanceLender,GetInfo,borrow}= require("../scripts/scripts.js")
const router = express.Router()

router.route("/pool").get(getpoolAddress)
router.route("/Info").post(GetInfo)
router.route("/balanceLender").post(GetBalanceLender)
router.route("/balanceContract").post(GetBalanceContract)
router.route("/lend").post(Lend)
router.route("/borrow").post(borrow)
router.route("/withdraw").post(withdraw)
router.route("/repay").post(repay)
router.route("/withdrawFromContract").post(withdrawFromContract)

module.exports = router 