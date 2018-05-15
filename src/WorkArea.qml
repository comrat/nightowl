Rectangle {
	property int maxWidth: 900;
	y: 50;
	width: parent.width > maxWidth ? maxWidth : parent.width;
	height: parent.height - 50;
	anchors.horizontalCenter: parent.horizontalCenter;
	color: colorTheme.workAreaColor;

	WebRtc {
		id: webRtc;

		onMessage(message): { log("Msg", message) }
		onServerStarted(link): { log("Server started", link) }
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
			}
		}

		ConnectPage {
			onConnect(ip, port): {
				client.ip = ip
				client.port = port
				client.connect()
				thread.serverSide = false
				contentStack.currentIndex = 1
			}
		}

		startThread: {
			thread.serverSide = true
			this.currentIndex = 1
			webRtc.createThread()
		}

		joinThread: { this.currentIndex = 2 }
	}
}
