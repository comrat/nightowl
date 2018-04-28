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
		delegate: Rectangle {
			x: model.currentUser ? 45% : 5%;
			width: model.newUser || model.userLeave ? 100% : 50%;
			height: model.newUser || model.userLeave ? newUserText.height : (message.height + 10 + (userName.text ? 30 : 0));
			color: model.newUser || model.userLeave ? "#0000" : (model.currentUser ? colorTheme.accentColor : colorTheme.messageColor);
			radius: 5;

			Text {
				id: newUserText;
				width: 100%;
				horizontalAlignment: Text.AlignHCenter;
				font.pixelSize: 18;
				color: colorTheme.headColor;
				text: model.newUser ? "Meet the " + model.newUser : (model.userLeave ? model.userLeave + " leaved" : "");
			}

			Text {
				id: userName;
				y: 5;
				x: 5%;
				font.pixelSize: 18;
				color: colorTheme.accentTextColor;
				text: model.currentUser || !model.name ? "" : model.name;
			}

			Text {
				id: message;
				y: 5 + (userName.text ? 30 : 0);
				x: 5%;
				width: 90%;
				font.pixelSize: 18;
				color: colorTheme.textColor;
				wrapMode: Text.WordWrap;
				text: model.text ? model.text : "";
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
