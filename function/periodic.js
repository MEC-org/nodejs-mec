const k = require('../appStructure/keyElements.js')
const pool = require('../commands/txpool-commands.js')

let listener = (name)=>{
	setInterval(() => {
	  	let a = new pool(name)
	  	pool.content
		  	.then(res=>{
		  		if(res) k.ipc[name].miner.start(1,(err,res)=>{console.log = function() {}})
		  		else k.ipc[name].miner.stop((err,res)=>{console.log = function() {}})
		  	})
		  	.catch(err=>{throw err})
	}, 500);
}

module.exports = {listener}