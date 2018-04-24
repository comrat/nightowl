Rectangle {
	property int maxWidth: 900;
	width: parent.width > maxWidth ? maxWidth : parent.width;
	height: parent.width > maxWidth ? 95% : 100%;
	anchors.horizontalCenter: parent.horizontalCenter;
	color: colorTheme.workAreaColor;

	WebSocketServer { id: server; }
	WebSocketClient { id: client; }

	PositionMixin { value: PositionMixin.Fixed; }

	PageStack {
		width: 100%;
		height: 100%;

		StartPage {
			onJoin: { /*TODO: impl*/ }
			onCreate: { /*TODO: impl*/ }
		}
	}
}
