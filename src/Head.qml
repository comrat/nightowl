Rectangle {
	id: headProto;
	signal optionChoosed;
	width: 100%;
	height: 50;
	color: colorTheme.headColor;

	PositionMixin { value: PositionMixin.Fixed; }

	ListModel { id: optionsModel; }

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

	fillOptions(options): { optionsModel.clear(); optionsModel.append(options) }
	clearOptions: { optionsModel.clear() }
}
