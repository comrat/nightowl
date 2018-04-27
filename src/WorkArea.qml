Rectangle {
	property int maxWidth: 900;
	y: 50;
	width: parent.width > maxWidth ? maxWidth : parent.width;
	height: parent.height - 50;
	anchors.horizontalCenter: parent.horizontalCenter;
	color: colorTheme.workAreaColor;

	WebSocketServer {
		id: server;
		port: "1471";

		onMessage(msg, con): { log("Message", msg, con) }
		onUserConnected(user): { log("onUserConnected", user) }
		onUserDisconnected(user, code, reason, wasClean): { log("onUserDisconnected", user, code, reason, wasClean) }
	}

	WebSocketClient { id: client; ip: "192.168.0.101"; port: "1471"; }

	PositionMixin { value: PositionMixin.Fixed; }

	PageStack {
		id: contentStack;
		width: 100%;
		height: 100%;

		StartPage {
			onJoin: { contentStack.joinThread() }
			onCreate: { contentStack.startThread() }
		}

		Thread { id: thread; }

		ConnectPage {
			onConnected: {
				client.connect()
				thread.server = false
				this.currentIndex = 1
			}
		}

		startThread: {
			thread.server = true
			this.currentIndex = 1
			server.start()
		}

		// joinThread: { this.currentIndex = 2 }
		joinThread: {
			client.connect()
			thread.server = false
			this.currentIndex = 1
		}
	}
}
