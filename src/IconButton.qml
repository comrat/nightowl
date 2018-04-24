WebItem {
	property string icon;
	width: 150;
	height: 150;
	radius: width / 2;
	color: colorTheme.accentColor;

	Image {
		x: 13%;
		y: 13%;
		width: 74%;
		height: 74%;
		source: parent.icon;
	}
}
