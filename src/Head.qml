Rectangle {
	id: headProto;
	signal menuPressed;
	signal optionChoosed;
	width: 100%;
	height: 50;
	color: colorTheme.headColor;

	PositionMixin { value: PositionMixin.Fixed; }

	ListModel { id: optionsModel; }

	MenuButton {
		icon: "res/menu.png";

		onClicked: { this.parent.menuPressed() }
	}

	ListView {
		width: contentWidth;
		anchors.right: parent.right;
		orientation: ListView.Horizontal;
		height: 100%;
		model: optionsModel;
		delegate: MenuButton {
			icon: model.icon;

			onClicked: { headProto.optionChoosed(model) }
		}
	}

	fillOptions(options): { optionsModel.append(options) }
	clearOptions: { optionsModel.clear() }
}
