const { ethers } = require('hardhat');
const { expect } = require('chai');
const { networks } = require('../hardhat.config');

describe("KevPair", () => {

    before( async() => {

        this.KevPair = await ethers.getContractFactory("KevPair");
        
        this.signers = await ethers.getSigners();
        this.owner = this.signers[0];
        this.alice = this.signers[1];
        this.bob = this.signers[2];

    });

    beforeEach( async () => {
        this.instance = await KevPair.deploy();
        await this.instance.deployed();
    })


    describe("()", () => {
        it("Should success", async () => {});
        it("Should fail", async () => {});
    });

    

    end( async () => {
        await networks.provider.request({
            method: "hardhat_reset",
            params: []
        })
    })

})