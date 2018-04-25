Rectangle {
	anchors.fill: parent;
	color: colorTheme.backgroundColor;

	ColorTheme { id: colorTheme; }

	WorkArea { }

	Head {
		onMenuPressed: { /*TODO: impl*/ }
	}

	onBackPressed: { _globals.closeApp() }
}
