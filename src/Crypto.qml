Object {
	generateRsaKey(passphrase, bits): {
		var bitsCount = bits ? bits : 1024
		this.rsaKey = window.cryptico.generateRSAKey(passphrase, bitsCount)
	}

	getPublicKey: {
		return window.cryptico.publicKeyString(this.rsaKey)
	}

	encrypt(msg, publicKey, signWithRsa): {
		if (signWithRsa)
			return window.cryptico.encrypt(msg, publicKey, this.rsaKey);
		else
			return window.cryptico.encrypt(msg, publicKey);
	}

	decrypt(msg): {
		return window.cryptico.decrypt(msg, this.rsaKey);
	}

	getPublicKeyId(cipher): {
		return window.cryptico.publicKeyID(cipher);
	}
}
