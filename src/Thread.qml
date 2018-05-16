Item {
	id: threadProto;
	signal sendMessage;
	property bool serverSide;
	width: 100%;
	height: 100%;

	ListModel { id: messagesModel; }

	ListView {
		width: 100%;
		height: parent.height - 60;
		contentFollowsCurrentItem: false;
		nativeScrolling: true;
		spacing: 10;
		model: messagesModel;
		delegate: ThreadMessageDelegate { }
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
				messagesModel.append({ "text": messageInput.text, "name": "user", "currentUser": true, "time": threadProto.getCurrentTime() })
				threadProto.sendMessage(messageInput.text)
				messageInput.text = ""
			}
		}
	}

	receiveMessage(msg, user): {
		if (user)
			messagesModel.append({ "text": msg, "name": user.remoteAddr || user.name, "currentUser": false, "time": this.getCurrentTime() })
		else
			messagesModel.append({ "text": msg, "name": "user", "currentUser": false, "time": this.getCurrentTime() })
	}

	userConnected(user): {
		log("userConnected", user)
		messagesModel.append({ "newUser": user.remoteAddr })
	}

	getCurrentTime: {
		var now = new Date()
		var h = now.getHours()
		var m = now.getMinutes()
		return (h < 10 ? "0" + h : h) + ":" + (m < 10 ? "0" + m : m)
	}

	userDisconnected(user, code, reason, wasClean): {
		log("userDisconnected", user)
		messagesModel.append({ "userLeave": user.remoteAddr })
	}
}
