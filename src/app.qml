Rectangle {
	anchors.fill: parent;
	color: colorTheme.backgroundColor;

	ColorTheme { id: colorTheme; }

	WebSocketServer { id: server; }
	WebSocketClient { id: client; }

	WorkArea { }

	Head { }
}
