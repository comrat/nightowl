Object {
	property string rsaKey;

	generateRsaKey(passphrase, bits): {
		//TODO: impl
		var bitsCount = bits ? bits : 1024
		this.rsaKey = ""
	}

	getPublicKey: {
		//TODO: impl
		// use this.rsaKey
		return ""
	}

	encrypt(msg, publicKey): {
		//TODO: impl
		return msg
	}

	decrypt(msg, publicKey): {
		//TODO: impl
		return msg
	}
}
