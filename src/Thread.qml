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

		onContentHeightChanged: {
			var ch = this.contentHeight
			var h = this.height
			if (ch < h)
				this.contentY = ch - h
			else if (ch - this.element.dom.scrollTop <= h + h / 2)
				this.element.dom.scrollTo(0, this.element.dom.scrollHeight);
		}
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

	receiveMessage(msg, userName): {
		if (userName)
			messagesModel.append({ "text": msg, "name": userName, "currentUser": false, "time": this.getCurrentTime() })
		else
			messagesModel.append({ "text": msg, "name": "OP", "currentUser": false, "time": this.getCurrentTime() })
	}

	userConnected(user): {
		log("userConnected", user)
		messagesModel.append({ "newUser": user.userName ? user.userName : "Unknown user" })
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
