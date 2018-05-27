WebItem {
	property string text;
	width: innerButtonText.paintedWidth + 20;
	height: 50;
	color: colorTheme.accentColor;

	Text {
		id: innerButtonText;
		x: (parent.width - width) / 2;
		height: 100%;
		verticalAlignment: Text.AlignVCenter;
		horizontalAlignment: Text.AlignHCenter;
		color: colorTheme.textColor;
		text: parent.text;
		font.pixelSize: 24;
	}
}
