Item {
	id: connectPageProto;
	signal connect;
	width: 100%;
	height: 100%;

	Column {
		y: 20;
		width: 100%;
		spacing: 10;

		Text {
			width: 100%;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.headColor;
			font.pixelSize: 21;
			text: qsTr("IP address");
		}

		IpInput {
			id: ipInput;
			anchors.horizontalCenter: parent.horizontalCenter;
		}

		Text {
			width: 100%;
			anchors.topMargin: 70;
			horizontalAlignment: Text.AlignHCenter;
			color: colorTheme.headColor;
			font.pixelSize: 21;
			text: qsTr("port");
		}

		NumberInput {
			id: portInput;
			width: 60;
			height: 20;
			anchors.horizontalCenter: parent.horizontalCenter;
			min: 1024;
			max: 10000;
			value: 1451;

			onCompleted: { this.value = 0 }
		}

		WebItem {
			width: 120;
			height: 50;
			anchors.topMargin: 70;
			color: colorTheme.accentColor;
			anchors.horizontalCenter: parent.horizontalCenter;

			Text {
				width: 100%;
				height: 100%;
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				color: colorTheme.textColor;
				text: "Connect";
				font.pixelSize: 24;
			}

			onClicked: { connectPageProto.connect(ipInput.value, portInput.value) }
		}
	}
}
