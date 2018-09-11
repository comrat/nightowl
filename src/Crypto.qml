Object {
	generateRsaKey(passphrase, bits): {
		var bitsCount = bits ? bits : 1024
		this.rsaKey = window.cryptico.generateRSAKey(passphrase, bitsCount)
	}

	getPublicKey: {
		return window.cryptico.publicKeyString(this.rsaKey)
	}

	encrypt(msg, publicKey): {
		return window.cryptico.encrypt(msg, publicKey);
	}

	decrypt(msg, publicKey): {
		return window.cryptico.decrypt(msg, this.rsaKey);
	}
}
