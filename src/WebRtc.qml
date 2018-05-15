Object {
	signame message;
	property bool activeDataChannel;

	createThread(callback): {
		var serverHost = this._serverHost
		var dataChannel = serverHost.createDataChannel('test', {reliable: true})
		var self = this
		this.activeDataChannel = dataChannel

		dataChannel.onopen = function(e) { log("Data channel opened", e) }
		dataChannel.onmessage = function(e) {
			if (e.data.size) {
				//TODO: imple file transmission
				// fileReceiver1.receive(e.data, {})
			} else {
				if (e.data.charCodeAt(0) == 2)
					return

				var data = JSON.parse(e.data)
				if (data.type === 'file') {
					//TODO: imple file transmission
					// fileReceiver1.receive(e.data, {})
				} else {
					self.message(data)
				}
			}
		}

		serverHost.createOffer(
			function(desc) { serverHost.setLocalDescription(desc, function() {}, function() {}) },
			function() { },
			{ 'optional': [] }
		)
	}

	onCompleted: {
		var cfg = { 'iceServers': [{'url': "stun:stun.gmx.net"}] }
		var con = { 'optional': [{'DtlsSrtpKeyAgreement': true}] }
		this._serverHost = new RTCPeerConnection(cfg, con)
		var serverHost = this.serverHost
		serverHost.onicecandidate = function (e) {
			log("onicecandidate", e)
			if (e.candidate == null)
				log("Got description", serverHost.localDescription)
		}
		this.activeDataChannel = false
	}
}
