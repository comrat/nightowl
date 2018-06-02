Row {
	signal join;
	signal create;
	anchors.horizontalCenter: parent.horizontalCenter;
	spacing: 50;
	height: 100%;

	IconButton {
		anchors.verticalCenter: parent.verticalCenter;
		icon: "res/create.png";
		text: "Create thread";

		onClicked: { this.parent.create() }
	}

	IconButton {
		anchors.verticalCenter: parent.verticalCenter;
		icon: "res/join.png";
		text: "Join thread";

		onClicked: { this.parent.join() }
	}
}
