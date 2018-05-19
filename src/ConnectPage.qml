Item {
	id: connectPageProto;
	signal pasteInvite;
	width: 100%;
	height: 100%;

	Column {
		property bool showOwnLabel;
		y: 10;
		width: 100%;
		spacing: 10;

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.headColor;
			font.pixelSize: 21;
			text: qsTr("Enter invite");
		}

		TextAreaInput {
			id: inviteText;
			width: 90%;
			anchors.horizontalCenter: parent.horizontalCenter;
			font.pixelSize: 18;
			backgroundColor: colorTheme.textArea;
		}

		Row {
			x: 5%;
			width: 100%;
			height: 35;
			spacing: 10;

			Text {
				anchors.verticalCenter: parent.verticalCenter;
				color: colorTheme.headColor;
				font.pixelSize: 21;
				text: qsTr("User name");
			}

			TextInput {
				id: nameInput;
				width: 60%;
				anchors.verticalCenter: parent.verticalCenter;
				font.pixelSize: 18;
				backgroundColor: colorTheme.textArea;
			}
		}

		TextButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			text: "Generate answer";

			onClicked: {
				log("text", inviteText.text)
				if (inviteText.text.length) {
					this.parent.showOwnLabel = true
					connectPageProto.pasteInvite({ answer: inviteText.text, userName: nameInput.text })
				}
			}
		}

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.headColor;
			font.pixelSize: 21;
			text: qsTr("Send this string to OP");
			visible: parent.showOwnLabel;
		}

		TextAreaInput {
			id: userHostDescription;
			width: 90%;
			anchors.horizontalCenter: parent.horizontalCenter;
			font.pixelSize: 18;
			backgroundColor: colorTheme.textArea;
		}

		onVisibleChanged: { if (value) this.showOwnLabel = false }
	}

	showAnswer(answer): {
		userHostDescription.text = answer
	}
}
