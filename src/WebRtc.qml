Object {
	signal message;
	signal serverStarted;
	signal userConnected;
	signal answerReceived;

	Base64 { id: base64; }

	createThread: {
		var serverHost = this._serverHost
		var dataChannel = serverHost.createDataChannel('test', {reliable: true})
		var self = this
		var context = this._context
		this.activeDataChannel = dataChannel

		dataChannel.onopen = context.wrapNativeCallback(function(e) { log("Data channel opened", e) })
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
		var offerDesc = new RTCSessionDescription(JSON.parse(base64.decode(offer)))
		log("Offer", offerDesc)
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

	addUser(answer): {
		var user = JSON.parse(base64.decode(answer))
		var answerDesc = new RTCSessionDescription(user)
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
			if (e.candidate == null)
				self.serverStarted(base64.encode(JSON.stringify(serverHost.localDescription)))
		})
		this.activeDataChannel = false

		this._clientHost = new RTCPeerConnection(cfg, con)
		var clientHost = this._clientHost
		clientHost.onicecandidate = this._context.wrapNativeCallback(function(e) {
			log("onicecandidate client", e)
			if (e.candidate == null) {
				self.answerReceived(base64.encode(JSON.stringify(clientHost.localDescription)))
			}
		})

		clientHost.ondatachannel = this._context.wrapNativeCallback(function(e) {
			var datachannel = e.channel || e;
			self.activeDataChannel = datachannel
			datachannel.onopen = function (e) { }
			datachannel.onmessage = function (e) {
				if (e.data.size) {
					//TODO: imple file transmission e.data
				} else {
					var data = JSON.parse(e.data)
					if (data.type === 'file') {
						//TODO: imple file transmission e.data
					} else {
						self.message(data)
					}
				}
			}
		})
	}
}
