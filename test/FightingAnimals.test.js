const Animal = artifacts.requires('./FightingAnimals.sol')

require('chai') 
    .use(require('chai-as-promised'))
    .should()

contract('Animal', (accounts) => {
    let contract
    
    before (async() => {
        contract = await FightingAnimals.deployed()
    })
    describe('deployement', async() => {
        it('deploy successfully', async () => {
            contract = await FightingAnimals.deployed()
            const address = contract.address
            console.log(address)
            assert.notEqual(address, 0x0)
            assert.notEqual(address,'')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        }) 
        it('has a name', async() => {
            const name = await contract.name()
            assert.equal(name,'Animal')
        })

        it('has a symbol', async() => {
            const symbol = await contract.symbol()
            assert.equal(symbol,'Animal')
        })
    })
})