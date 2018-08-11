Object {
	signal message;
	signal serverStarted;
	signal userConnected;
	signal answerReceived;
	signal connectionEstablished;
	property string threadLink;
	property string currentUser;
	property string publicKey;

	Base64 { id: base64; }
	Crypto { id: crypto; }

	createThread: {
		var serverHost = this._serverHost
		var dataChannel = serverHost.createDataChannel('test', {reliable: true})
		var self = this
		var context = this._context
		this.activeDataChannel = dataChannel

		crypto.generateRsaKey("password")
		this.publicKey = crypto.getPublicKey()

		dataChannel.onopen = context.wrapNativeCallback(function(e) { log("Data channel opened", e); dataChannel.send(JSON.stringify({ invite: true })); })
		dataChannel.onmessage = context.wrapNativeCallback(function(e) {
			if (e.data.size) {
				//TODO: imple file transmission e.data
			} else {
				if (e.data.charCodeAt(0) == 2)
					return

				var data = JSON.parse(e.data)
				if (data.type === 'file') {
					//TODO: imple file transmission e.data
				} else {
					data.message = crypto.decrypt(data.message)
					self.message(data)
				}
			}
		})

		serverHost.createOffer(
			function(desc) { serverHost.setLocalDescription(desc, function() {}, function() {}) },
			function() { },
			{ 'optional': [] }
		)
	}

	pasteInvite(offer): {
		this.currentUser = offer.userName
		var answer = JSON.parse(base64.decode(offer.answer))
		this.publicKey = answer.publicKey
		var offerDesc = new RTCSessionDescription(answer.desc)
		var clientHost = this._clientHost
		clientHost.setRemoteDescription(offerDesc)
		clientHost.createAnswer(
			function(answerDesc) {
				log("Answer", answerDesc)
				clientHost.setLocalDescription(answerDesc)
			},
			function () { },
			{ 'optional': [] }
		)
	}

	sendMessage(msg): { this.activeDataChannel.send(JSON.stringify({ message: crypto.encrypt(msg, this.publicKey), user: this.currentUser })); }

	addUser(answer): {
		var user = JSON.parse(base64.decode(answer))
		var description = user.desc
		var answerDesc = new RTCSessionDescription(description)
		this._serverHost.setRemoteDescription(answerDesc)
		log("User", user)
		this.userConnected(user)
	}

	onCompleted: {
		var cfg = { 'iceServers': [{'url': "stun:stun.gmx.net"}] }
		var con = { 'optional': [{'DtlsSrtpKeyAgreement': true}] }
		this._serverHost = new RTCPeerConnection(cfg, con)
		var serverHost = this._serverHost
		var self = this
		serverHost.onicecandidate = this._context.wrapNativeCallback(function(e) {
			log("onicecandidate", e)
			if (e.candidate == null) {
				self.threadLink = base64.encode(JSON.stringify({ desc: serverHost.localDescription, publicKey: crypto.publicKey }))
				self.serverStarted(self.threadLink)
			}
		})
		this.activeDataChannel = null

		this._clientHost = new RTCPeerConnection(cfg, con)
		var clientHost = this._clientHost
		clientHost.onicecandidate = this._context.wrapNativeCallback(function(e) {
			log("onicecandidate client", e, "curr", self.currentUser)
			if (e.candidate == null) {
				self.answerReceived(base64.encode(JSON.stringify({ desc: clientHost.localDescription, userName: self.currentUser })))
			}
		})

		clientHost.ondatachannel = this._context.wrapNativeCallback(function(e) {
			var datachannel = e.channel || e;
			self.activeDataChannel = datachannel
			datachannel.onopen = context.wrapNativeCallback(function (e) { log("Client datachannel opened") })
			datachannel.onmessage = context.wrapNativeCallback(function (e) {
				if (e.data.size) {
					//TODO: imple file transmission e.data
				} else {
					var data = JSON.parse(e.data)
					if (data.type === 'file') {
						//TODO: imple file transmission e.data
					} else {
						if (data.invite) {
							self.connectionEstablished()
						} else {
							data.message = crypto.decrypt(data.message, this.publicKey)
							self.message(data)
						}
					}
				}
			})
		})
	}
}
