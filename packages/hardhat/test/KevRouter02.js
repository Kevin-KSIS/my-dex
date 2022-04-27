const { ethers } = require('hardhat');
const { expect } = require('chai');
const { networks } = require('../hardhat.config');

describe("KevRouter02", () => {

    before( async() => {

        this.KevRouter02 = await ethers.getContractFactory("KevRouter02");
        
        this.signers = await ethers.getSigners();
        this.owner = this.signers[0];
        this.alice = this.signers[1];
        this.bob = this.signers[2];

    });

    beforeEach( async () => {
        this.instance = await KevRouter02.deploy();
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