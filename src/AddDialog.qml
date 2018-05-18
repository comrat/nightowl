Rectangle {
	id: addDialogProto;
	signal addUser;
	width: 100%;
	height: 100%;
	color: "#000d";
	visible: false;

	Column {
		y: 50;
		width: 100%;
		spacing: 10;

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.textColor;
			font.pixelSize: 21;
			text: qsTr("Enter user answer");
		}

		TextAreaInput {
			id: userAnswerText;
			width: 90%;
			height: 100;
			anchors.horizontalCenter: parent.horizontalCenter;
			font.pixelSize: 18;
			backgroundColor: colorTheme.textArea;
		}

		TextButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			text: "Add";

			onClicked: {
				addDialogProto.addUser(userAnswerText.text)
				addDialogProto.hide()
			}
		}
	}

	MenuButton {
		height: 50;
		anchors.right: parent.right;
		icon: "res/close.png";

		onClicked: { addDialogProto.hide() }
	}

	show: { this.visible = true }
	hide: { this.visible = false }
}
