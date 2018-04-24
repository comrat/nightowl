Rectangle {
	signal menuPressed;
	width: 100%;
	height: 50;
	color: colorTheme.headColor;

	PositionMixin { value: PositionMixin.Fixed; }

	WebItem {
		width: height;
		height: 100%;

		Image {
			x: 13%;
			y: 13%;
			width: 74%;
			height: 74%;
			source: "res/menu.png";
		}

		onClicked: { this.parent.menuPressed() }
	}
}
