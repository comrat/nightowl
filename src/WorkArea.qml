Rectangle {
	property int maxWidth: 900;
	width: parent.width > maxWidth ? maxWidth : parent.width;
	height: 95%;
	anchors.horizontalCenter: parent.horizontalCenter;
	color: colorTheme.workAreaColor;

	PositionMixin { value: PositionMixin.Fixed; }
}
