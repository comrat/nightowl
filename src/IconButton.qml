WebItem {
	id: iconButtonProto;
	property string icon;
	property string text;
	width: 150;
	height: 180;

	Rectangle {
		width: 150;
		height: 150;
		radius: width / 2;
		color: colorTheme.accentColor;

		Image {
			x: 13%;
			y: 13%;
			width: 74%;
			height: 74%;
			source: iconButtonProto.icon;
		}
	}

	Text {
		width: 100%;
		anchors.bottom: parent.bottom;
		font.pixelSize: 24;
		color: colorTheme.accentColor;
		text: parent.text;
		horizontalAlignment: Text.AlignHCenter;
	}
}
