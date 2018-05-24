Dialog {
	id: addDialogProto;
	signal addUser;

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
}
