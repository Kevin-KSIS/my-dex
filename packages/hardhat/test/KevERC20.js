const { ethers } = require('hardhat');
const { expect } = require('chai');
const { networks } = require('../hardhat.config');

describe("KevERC20", () => {

    before( async() => {
        this.parseToEther = ethers.utils.parseEther;
        this.parseToNumber = ethers.utils.formatEther;

        this.KevERC20 = await ethers.getContractFactory("KevERC20");
        
        this.signers = await ethers.getSigners();
        this.owner = this.signers[0];
        this.alice = this.signers[1];
        this.bob = this.signers[2];

    });

    beforeEach( async () => {
        this.instance = await KevERC20.deploy();
        await this.instance.deployed();
    })


    describe("approve()", () => {

        it("Should success", async () => {
            await this.instance.connect(this.alice).approve(this.bob.address, this.parseToEther('1000'));
            const allowanceOfAlice = await this.instance.allowance(this.alice.address);
            expect(allowanceOfAlice).to.equal(this.parseToEther('1000'));
        });

        it("Should fail", async () => {
            await this.instance.connect(this.alice).approve(this.bob.address, this.parseToEther('-1000'));
            const allowanceOfAlice = await this.instance.allowance(this.alice.address);
            // expect(allowanceOfAlice).to.equal(this.parseToEther('-1000'));
        });

    });

    describe("transfer()", () => {
        it("Should success", async () => {});
        it("Should fail", async () => {});
    });
    
    describe("transferFrom()", () => {
        it("Should success", async () => {});
        it("Should fail", async () => {});
    });
    
    describe("permit()", () => {
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