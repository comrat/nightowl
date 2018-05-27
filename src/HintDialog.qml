Dialog {
	id: hintDialogProto;
	signal share;
	signal dontShowAgain;

	Column {
		y: 80;
		width: 100%;
		spacing: 10;

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.textColor;
			font.pixelSize: 21;
			text: qsTr("Click here to share your thread");
		}

		Column {
			y: 40;
			width: 250;
			anchors.horizontalCenter: parent.horizontalCenter;
			spacing: 10;

			TextButton {
				width: 100%;
				text: "Ok";

				onClicked: { hintDialogProto.hide() }
			}

			TextButton {
				width: 100%;
				text: "Don't show again";

				onClicked: {
					hintDialogProto.dontShowAgain()
					hintDialogProto.hide()
				}
			}
		}
	}

	Image {
		anchors.right: parent.right;
		anchors.rightMargin: 48;
		source: "res/pointer.png";
	}

	MenuButton {
		height: 50;
		anchors.right: parent.right;
		anchors.rightMargin: 50;
		icon: "res/share.png";

		onClicked: { hintDialogProto.share() }
	}
}
