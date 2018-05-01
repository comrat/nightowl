Rectangle {
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

	Text {
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		anchors.margins: 5;
		font.pixelSize: 12;
		color: colorTheme.bottomTextColor;
		text: model.time ? model.time : "";
	}
}
