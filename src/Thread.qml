Item {
	property bool server;
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
			height: message.height + 10 + (userName.text ? 30 : 0);
			color: model.currentUser ? colorTheme.accentColor : colorTheme.messageColor;
			radius: 5;

			Text {
				id: userName;
				y: 5;
				x: 5%;
				font.pixelSize: 18;
				color: colorTheme.accentTextColor;
				text: model.currentUser ? "" : model.name;
			}

			Text {
				id: message;
				y: 5 + (userName.text ? 30 : 0);
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
			id: messageInput;
			width: 100% - parent.height;
			font.pixelSize: 18;
			backgroundColor: colorTheme.textArea;
		}

		WebItem {
			x: parent.width - width;
			width: height;
			height: parent.height;
			visible: messageInput.text;

			Image {
				x: 10%;
				y: 10%;
				width: 80%;
				height: 80%;
				source: "res/send.png";
			}

			onClicked: {
				messagesModel.append({ "text": messageInput.text, "name": "user", "currentUser": true })
				messageInput.text = ""
			}
		}
	}
}
