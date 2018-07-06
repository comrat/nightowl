Dialog {
	id: hintDialogProto;
	signal share;
	focus: true;

	Column {
		y: 100;
		width: 100%;
		spacing: 10;

		Text {
			x: 5%;
			width: 90%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.textColor;
			font.pixelSize: 21;
			wrapMode: Text.WordWrap;
			text: qsTr("Choose one of the top menu item to copy, share invite to your thread or approve new user by its answer");
		}

		Column {
			y: 20;
			width: 250;
			anchors.horizontalCenter: parent.horizontalCenter;
			spacing: 10;

			TextButton {
				width: 100%;
				text: "Got it";

				onClicked: { hintDialogProto.hide() }
			}

			TextButton {
				width: 100%;
				text: "Don't show again";

				onClicked: {
					storage.setValue("dontShowHintAgain", true)
					hintDialogProto.hide()
				}
			}
		}
	}

	Image {
		y: 55;
		anchors.right: parent.right;
		anchors.rightMargin: 68;
		source: "res/pointer.png";
	}
}
