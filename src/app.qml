Rectangle {
	anchors.fill: parent;
	color: colorTheme.backgroundColor;

	ColorTheme { id: colorTheme; }

	Device { id: device; }

	WorkArea { }

	Head {
		onMenuPressed: { /*TODO: impl*/ }
	}

	onBackPressed: { _globals.closeApp() }

	onCompleted: {
		if (device.lockOrientation)
			device.lockOrientation("portrait-primary")
	}
}
