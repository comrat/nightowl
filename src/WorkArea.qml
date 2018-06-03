Rectangle {
	id: workAreaProto;
	signal clearMenu;
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

		onMessage(messageData): { thread.receiveMessage(messageData.message, messageData.user) }

		onConnectionEstablished: { contentStack.joinThread() }

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
			onJoin: { contentStack.connectToThread() }
			onCreate: { contentStack.startThread() }
		}

		Thread {
			id: thread;

			onSendMessage(msg): { webRtc.sendMessage(msg) }
			onBackPressed: { contentStack.gotoMain(); return true }
		}

		ConnectPage {
			id: connectPage;

			onPasteInvite(invite): { webRtc.pasteInvite(invite) }
			onBackPressed: { contentStack.gotoMain(); return true }
		}

		startThread: {
			thread.serverSide = true
			workAreaProto.fillOptions([{ 'icon': "res/copy.png", 'action': "copy" }, { 'icon': "res/share.png", 'action': "share" }, { 'icon': "res/add.png", 'action': "add" }])
			this.currentIndex = 1
			webRtc.createThread()
		}

		gotoMain: { workAreaProto.clearMenu(); this.currentIndex = 0 }
		joinThread: { this.currentIndex = 1 }
		connectToThread: { this.currentIndex = 2 }
	}

	Notification { id: notificator; }

	addUser(userAnswer): { webRtc.addUser(userAnswer) }

	share: {
		if (window.navigator && window.navigator.share)
			window.navigator.share("Invite to thread:\n" + webRtc.threadLink, "Share invite to your thread", "plain/text")
		else
			log("Share method is undefined, add cordova-plugin-share")
	}

	copy: {
		if (window.cordova && window.cordova.plugins && window.cordova.plugins.clipboard) {
			try {
				window.cordova.plugins.clipboard.copy(webRtc.threadLink);
				notificator.show("Link was copied to the clipboard")
			} catch(e) {
				log("Copy to clipboard failed", e)
			}
		} else {
			log("Failed to copy to clipboard corresponded method is undefined")
		}
	}

	chooseOption(option): {
		if (!option) {
			log("Invalid option")
			return
		}

		switch(option.action) {
			case "add": this.showAddDialog(); break
			case "copy": this.copy(); break
			case "share": this.share(); break
		}
	}
}
