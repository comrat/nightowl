Item {
	id: connectPageProto;
	signal pasteInvite;
	width: 100%;
	height: 100%;

	Column {
		property bool showOwnLabel;
		y: 20;
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

		WebItem {
			width: 120;
			height: 50;
			color: colorTheme.accentColor;
			anchors.horizontalCenter: parent.horizontalCenter;

			Text {
				width: 100%;
				height: 100%;
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				color: colorTheme.textColor;
				text: "Generate";
				font.pixelSize: 24;
			}

			onClicked: {
				log("text", inviteText.text)
				if (inviteText.text.length) {
					this.parent.inviteText = true
					connectPageProto.pasteInvite(inviteText.text)
				}
			}
		}

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.headColor;
			font.pixelSize: 21;
			text: qsTr("Send");
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
}
