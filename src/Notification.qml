Rectangle {
	id: notificationProto;
	property string text;
	property bool display;
	x: 10%;
	width: 80%;
	height: notificationText.height + 10;
	opacity: display ? 1.0 : 0.0;
	transform.translateY: parent.height - (display ? notificationText.height + 20 : 0);
	color: colorTheme.shadowColor;
	focus: false;
	radius: 10;

	Text {
		id: notificationText;
		y: 5;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		color: colorTheme.textColor;
		text: notificationProto.text;
		font.pixelSize: 16;
		wrapMode: Text.WordWrap;
	}

	Timer {
		id: showTimer;
		interval: 3000;

		onTriggered: { notificationProto.display = false }
	}

	show(text): {
		notificationText.text = text
		this.display = true
		showTimer.restart()
	}

	Behavior on transform, opacity { Animation { duration: 300; } }
}
