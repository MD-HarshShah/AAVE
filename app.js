const express = require('express')
const app = express()

require("dotenv").config()

const LendingAndBorrowing = require("./router/routes.js")
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const PORT = process.env.PORT || 8000

app.use("/",LendingAndBorrowing)

app.listen(PORT,()=>{
    console.log(`${PORT} is succcessfully connected`)
})