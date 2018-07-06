Rectangle {
	width: 100%;
	height: 100%;
	color: colorTheme.shadowColor;
	visible: false;

	MenuButton {
		height: 50;
		anchors.right: parent.right;
		icon: "res/close.png";

		onClicked: { this.parent.hide() }
	}

	show: { this.visible = true }
	hide: { this.visible = false }

	onBackPressed: { this.hide(); return true }
}
