Rectangle {
	id: workAreaProto;
	signal fillOptions;
	signal clearOptions;
	signal showAddDialog;
	signal showHintDialog;
	property int maxWidth: 900;
	y: 50;
	width: parent.width > maxWidth ? maxWidth : parent.width;
	height: parent.height - 50;
	anchors.horizontalCenter: parent.horizontalCenter;
	color: colorTheme.workAreaColor;

	WebRtc {
		id: webRtc;

		onMessage(message): { log("Msg", message) }

		userConnected(user): { thread.userConnected(user) }

		onServerStarted(link): {
			log("Server started", link)
			storage.getValueOrDefault(
				"dontShowHintAgain",
				function(value) {
					if (!value)
						workAreaProto.showHintDialog()
				},
				false
			)
		}

		onAnswerReceived(answer): {
			log("AnswerReceived", answer)
			connectPage.showAnswer(answer)
		}
	}

	PositionMixin { value: PositionMixin.Fixed; }

	PageStack {
		id: contentStack;
		width: 100%;
		height: 100%;

		StartPage {
			onJoin: { contentStack.joinThread() }
			onCreate: { contentStack.startThread() }
		}

		Thread {
			id: thread;

			onSendMessage(msg): { }
		}

		ConnectPage {
			id: connectPage;

			onPasteInvite(invite): { webRtc.pasteInvite(invite) }
		}

		startThread: {
			thread.serverSide = true
			workAreaProto.fillOptions([{ 'icon': "res/share.png", 'action': "share" }, { 'icon': "res/add.png", 'action': "add" }])
			this.currentIndex = 1
			webRtc.createThread()
		}

		joinThread: { this.currentIndex = 2 }
	}

	addUser(userAnswer): {
		webRtc.addUser(userAnswer)
	}

	chooseOption(option): {
		if (!option) {
			log("Invalid option")
			return
		}

		switch(option.action) {
			case "add": this.showAddDialog(); break
			case "share":
				if (window.navigator && window.navigator.share)
					window.navigator.share("Invite to thread:\n" + webRtc.threadLink, "Share invite to your thread", "plain/text")
				else
					log("Share method is undefined, add cordova-plugin-share")
				break
		}
	}
}
