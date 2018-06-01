Rectangle {
	anchors.fill: parent;
	color: colorTheme.backgroundColor;

	ColorTheme { id: colorTheme; }

	Device { id: device; }

	JsonStorage { id: storage; }

	WorkArea {
		id: workArea;

		onClearMenu: { head.clearOptions() }
		onShowAddDialog: { addDialog.show() }
		onShowHintDialog: { hintDialog.show() }
		onFillOptions(options): { head.fillOptions(options) }
	}

	Head {
		id: head;

		onMenuPressed: { /*TODO: impl*/ }
		onOptionChoosed(option): { workArea.chooseOption(option) }
	}

	AddDialog {
		id: addDialog;

		onAddUser(userAnswer): { workArea.addUser(userAnswer) }
	}

	HintDialog {
		id: hintDialog;

		onShare: { workArea.share() }
	}

	onBackPressed: { _globals.closeApp() }

	onCompleted: {
		if (device.lockOrientation)
			device.lockOrientation("portrait-primary")
	}
}
