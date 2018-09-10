Object {
	property string rsaKey;

	generateRsaKey(passphrase, bits): {
		var bitsCount = bits ? bits : 1024
		this.rsaKey = window.cryptico.generateRSAKey("test", bitsCount)
	}

	getPublicKey: {
		return cryptico.publicKeyString(this.rsaKey)
	}

	encrypt(msg, publicKey): {
		return cryptico.encrypt(msg, publicKey);
	}

	decrypt(msg, publicKey): {
		return cryptico.decrypt(msg, publicKey);
	}
}
