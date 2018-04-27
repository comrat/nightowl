Object {
	id: serverProto;
	signal message;
	signal userConnected;
	signal userDisconnected;
	property bool started;
	property bool autostart;
	property string ip;
	property string port;

	Timer {
		id: startDelayTimer;
		interval: 2000;

		onTriggered: { this.parent.start() }
	}

	send(msg): {
		// log("Send", msg, "strted", this.started, "server", this._wsserver, "user", this._user)
		// if (!this.started || !this._wsserver || !this._user)
		// 	return
		// this._wsserver.send({'uuid': this._user.uuid}, msg)
		//TODO: reimplement
	}

	start: {
		var context = this._context

		if (!window.cordova || !window.cordova.plugins) {
			log("WSS Plugin wasn't initialized")
			return
		}

		var wsserver = window.cordova.plugins.wsserver;
		var port = this.port
		var self = this
		wsserver.start(port, {
			'onFailure': context.wrapNativeCallback(function(addr, port, reason) {
				log('Stopped listening on %s:%d. Reason: %s', addr, port, reason);
				self.started = false
			}),
			'onOpen': context.wrapNativeCallback(function(user) {
				log('A user connected:', user);
				self.userConnected(user)
			}),
			'onMessage': context.wrapNativeCallback(function(user, msg) {
				self.message(msg, user)
			}),
			'onClose': context.wrapNativeCallback(function(conn, code, reason, wasClean) {
				log('A user disconnected from %s', conn.remoteAddr);
				self.userDisconnected(conn, code, reason, wasClean)
			})
		}, context.wrapNativeCallback(function onStart(addr, port) {
			log('Listening on address', addr, "port", port);
			self.started = true
		}), context.wrapNativeCallback(function onDidNotStart(reason) {
			log('Did not start. Reason: %s', reason);
			self.started = false
		}));

		wsserver.getInterfaces(context.wrapNativeCallback(function(interfaces) {
			log("Got interfaces", interfaces)
			for (var i in interfaces) {
				var iface = interfaces[i]
				if (iface && iface.ipv4Addresses && iface.ipv4Addresses.length)
					parent.ip = iface.ipv4Addresses[0]
			}
		}))

		parent._wsserver = wsserver
	}

	onCompleted: { if (this.autostart) startDelayTimer.restart() }
}
