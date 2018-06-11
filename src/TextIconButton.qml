WebItem {
	property string text;
	property string icon;
	width: innerButtonText.paintedWidth + height + 25;
	height: 50;
	color: colorTheme.accentColor;

	Image {
		x: 5;
		y: 5;
		width: height;
		height: parent.height - 10;
		source: parent.icon;
	}

	Text {
		id: innerButtonText;
		x: parent.height + 5;
		width: parent.width - parent.height - 10;
		height: 100%;
		verticalAlignment: Text.AlignVCenter;
		horizontalAlignment: Text.AlignHCenter;
		color: colorTheme.textColor;
		text: parent.text;
		font.pixelSize: 24;
	}
}
