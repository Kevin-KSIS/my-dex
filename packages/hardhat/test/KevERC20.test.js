const { ethers } = require('hardhat');
const { expect } = require('chai');

describe("Kev ERC20", () => {
    var contractIns;
    var owner, caller, user;

    beforeEach( async() => {

        const contractFactory = await ethers.getContractFactory("KevERC20");
        contractIns = await contractFactory.deploy();
        contractIns.deployed();

        [owner, caller, user] = await ethers.getSigners();

    });

    describe("transferFrom()", () => {

        it("Transfer without allowance", async () => {
            // mint to user
            await contractIns.mint(user.address, ethers.utils.parseEther('1000'));
            const balanceOfUser = await contractIns.balanceOf(user.address);
            console.log(`\t> Balance of user (${user.address.substring(0, 6)}): `, ethers.utils.formatEther(balanceOfUser));
            expect(balanceOfUser).to.equal(
                ethers.utils.parseEther('1000')
            );

            // check allowance of caller
            const allowanceOfCallerForUser = await contractIns.allowance(user.address, caller.address);
            console.log(`\t> Allowance of caller (${caller.address.substring(0, 6)}) for user (${user.address.substring(0, 6)}): ${allowanceOfCallerForUser}`);
            expect(allowanceOfCallerForUser).to.equal(
                ethers.utils.parseEther('0')
            );

            // transfer without permit
            await contractIns.transferFrom(
                user.address, // from
                caller.address, // to,
                ethers.utils.parseEther('1000') // value
            );
            const balanceOfCaller = await contractIns.balanceOf(caller.address);
            console.log(`\t> Balance of caller (${caller.address.substring(0, 6)}): `, ethers.formatEther(balanceOfCaller));
            expect(balanceOfCaller).to.equal(
                ethers.utils.parseEther('1000')
            ); 

        })

    })

})