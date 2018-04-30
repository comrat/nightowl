Item {
	id: threadProto;
	signal sendMessage;
	property bool serverSide;
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
		delegate: ThreadMessageDelegate { }

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
				threadProto.sendMessage(messageInput.text)
				messageInput.text = ""
			}
		}
	}

	receiveMessage(msg, user): {
		messagesModel.append({ "text": msg, "name": user.remoteAddr || user.name, "currentUser": false })
	}

	userConnected(user): {
		log("userConnected", user)
		messagesModel.append({ "newUser": user.remoteAddr })
	}

	userDisconnected(user, code, reason, wasClean): {
		log("userDisconnected", user)
		messagesModel.append({ "userLeave": user.remoteAddr })
	}
}
