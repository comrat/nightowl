Item {
	id: connectPageProto;
	signal copy;
	signal share;
	signal error;
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
			width: 90%;
			spacing: 10;
			height: 50;

			Text {
				id: nameLabel;
				anchors.verticalCenter: parent.verticalCenter;
				color: colorTheme.headColor;
				font.pixelSize: 21;
				text: qsTr("User name");
			}

			TextInput {
				id: nameInput;
				anchors.left: nameLabel.right;
				anchors.right: parent.right;
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				anchors.leftMargin: 10;
				font.pixelSize: 18;
				backgroundColor: colorTheme.textArea;
			}
		}

		TextButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			text: "Generate answer";

			onClicked: {
				log("text", inviteText.text)
				if (inviteText.text.length && nameInput.text.length)
					connectPageProto.pasteInvite({ answer: inviteText.text, userName: nameInput.text })
				else
					connectPageProto.error("Fill invite and user name")
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

			onTextChanged: { this.parent.showOwnLabel = value }
		}

		Row {
			height: 50;
			anchors.horizontalCenter: parent.horizontalCenter;
			spacing: 10;

			TextIconButton {
				icon: "res/share.png";
				text: "Share";

				onClicked: { connectPageProto.share(userHostDescription.text) }
			}

			TextIconButton {
				icon: "res/copy.png";
				text: "Copy";

				onClicked: { connectPageProto.copy(userHostDescription.text) }
			}
		}

		onVisibleChanged: { if (value) this.showOwnLabel = false }
	}

	showAnswer(answer): {
		userHostDescription.text = answer
	}
}
