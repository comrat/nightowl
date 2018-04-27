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

		onMessage(msg, con): { thread.receiveMessage(msg, con) }
		onUserConnected(user): { thread.userConnected(user) }
		onUserDisconnected(user, code, reason, wasClean): { log("onUserDisconnected", user, code, reason, wasClean) }
	}

	WebSocketClient { id: client; }

	PositionMixin { value: PositionMixin.Fixed; }

	PageStack {
		id: contentStack;
		width: 100%;
		height: 100%;

		StartPage {
			onJoin: { contentStack.joinThread() }
			onCreate: { contentStack.startThread() }
		}

		Thread {
			id: thread;

			onSendMessage(msg): { client.send(msg) }
		}

		ConnectPage {
			onConnect(ip, port): {
				client.ip = ip
				client.port = port
				client.connect()
				thread.server = false
				log("CONNEC")
				contentStack.currentIndex = 1
			}
		}

		startThread: {
			thread.server = true
			this.currentIndex = 1
			server.start()
		}

		joinThread: { this.currentIndex = 2 }
	}
}
