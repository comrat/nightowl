Item {
	width: 100%;
	height: 100%;

	ListModel { id: messagesModel; }

	ListView {
		width: 100%;
		anchors.bottom: parent.bottom;
		anchors.bottomMargin: 60;
		height: contentHeight;
		spacing: 10;
		model: messagesModel;
		delegate: Rectangle {
			x: model.currentUser ? 45% : 5%;
			width: 50%;
			height: message.height + 10;
			color: model.currentUser ? colorTheme.accentColor : colorTheme.messageColor;
			radius: 5;

			Text {
				id: message;
				y: 5;
				x: 5%;
				width: 90%;
				font.pixelSize: 18;
				color: colorTheme.textColor;
				wrapMode: Text.WordWrap;
				text: model.text;
			}
		}

		Behavior on contentHeight { Animation { duration: 300; } }
	}

	Rectangle {
		width: 100%;
		height: 50;
		anchors.bottom: parent.bottom;
		color: colorTheme.textArea;

		TextAreaInput {
			width: 100% - parent.height;
			font.pixelSize: 18;
			color: colorTheme.textArea;
		}

		WebItem {
			x: parent.width - width;
			width: height;
			height: parent.height;

			Image {
				x: 10%;
				y: 10%;
				width: 80%;
				height: 80%;
				source: "res/send.png";
			}

			onClicked: {
				messagesModel.append({ "text": "11111 2222 33 44444 111111 44444 000", "name": "user", "currentUser": true })
			}
		}
	}

	onCompleted: {
		var data = [
			{ "text": "11111 2222 33 44444 111111 44444 000", "name": "user", "currentUser": true },
			{ "text": "Testmessage ololo", "name": "user", "currentUser": false }
		]
		messagesModel.append(data)
	}
}
