WebItem {
	property string text;
	width: 120;
	height: 50;
	color: colorTheme.accentColor;

	Text {
		width: 100%;
		height: 100%;
		verticalAlignment: Text.AlignVCenter;
		horizontalAlignment: Text.AlignHCenter;
		color: colorTheme.textColor;
		text: parent.text;
		font.pixelSize: 24;
	}
}
