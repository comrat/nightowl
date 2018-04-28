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
		onUserDisconnected(user, code, reason, wasClean): { thread.userDisconnected(user, code, reason, wasClean) }
	}

	WebSocketClient {
		id: client;

		onMessage(msg, con): { thread.receiveMessage(msg, con) }
	}

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

			onSendMessage(msg): {
				log("sendmess", this.server, "func", server.sendMessage, "server", server)
				if (this.serverSide)
					server.sendMessage(msg)
				else
					client.send(msg)
			}
		}

		ConnectPage {
			onConnect(ip, port): {
				client.ip = ip
				client.port = port
				client.connect()
				thread.serverSide = false
				log("CONNEC")
				contentStack.currentIndex = 1
			}
		}

		startThread: {
			thread.serverSide = true
			this.currentIndex = 1
			server.start()
		}

		joinThread: { this.currentIndex = 2 }
	}
}
