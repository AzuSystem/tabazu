import QtQuick
import QtQuick.Controls
import QtQuick.Window
// import Qt5Compat.GraphicalEffects
import QtQuick.Effects

Window {
	id: window
	title: "Tabazu"
	visible: true
	width: screen.width / 5
	height: screen.height
	// flags: Qt.FramelessWindowHint
	flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
	// flags: Qt.FramelessWindowHint | Qt.X11BypassWindowManagerHint | Qt.WindowStaysOnBottomHint
	color: "transparent"
	x: screen.width - width
	opacity: 0.0

	Behavior on opacity {
		NumberAnimation {
			easing: Easing.InOutQuart
			duration: 250
		}
	}

	Rectangle {
		anchors.fill: parent
		gradient: Gradient {
			orientation: Gradient.Horizontal
			GradientStop { position: 0.0; color: "#00000000" }
			GradientStop { position: 1.0; color: "#60000000" }
		}

		ListModel {
			id: appList
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
			ListElement { name: "apppp" }
		}

		// ListView {
		// 	anchors.fill: parent
		// 	model: appList
		// 	// interactive: false


		// 	delegate: Text {
		// 		text: model.name
		// 		anchors.right: parent.right
		// 		y: 20
		// 	}

		// }

		Flickable {
			anchors.fill: parent
			flickableDirection: Flickable.VerticalFlick
			id: scroll
			interactive: false
			anchors.rightMargin: -window.width

			property int scrollIndex: 0

			Keys.onPressed: function(event) {
				if ( event.key === Qt.Key_Tab ) {
					scrollIndex += 1
					event.accepted = true

					if ( scrollIndex > appList.count / 2 ) {
						scrollIndex = -scrollIndex
					}
				} else if ( event.key === Qt.Key_Backtab ) {
					scrollIndex -= 1
					event.accepted = true
					
					if ( scrollIndex < -appList.count / 2 ) {
						scrollIndex = -scrollIndex
					}
				}
			}

			Timer {
				id: closeDelay
				interval: 500
				repeat: false

				onTriggered: {
					window.close()
				}
			}

			Keys.onEscapePressed: {
				closeAnim.start()
				window.opacity = 0.0;
				closeDelay.start()
			}

			Behavior on anchors.rightMargin {
				NumberAnimation {
					easing: Easing.OutCirc
					duration: 350
				}
			}

			Component.onCompleted: {
				forceActiveFocus()
			}

			Repeater {
				model: appList


				delegate: Text {
					text: model.name
					// anchors.right: parent.right
					font.pixelSize: 15

					// property real realY: mapToItem(null, 0, 0).y;
					property real realY: scroll.y + y - scroll.contentY;

					// y: ( index * 20 ) + (parent.height / 2)
					y: ( index - ( 20 - 1 ) / 2 ) * 20 + scroll.height / 2 + ( -scroll.scrollIndex * 20 ) 

					x: ( 0.002 * Math.pow(realY - (window.height / 2), 2) ) + scroll.width - width - 50

					color: "#ffffffff"

					layer.enabled: true
					layer.effect: MultiEffect {
						shadowEnabled: true
						shadowBlur: 0.6
						shadowOpacity: 0.7
						shadowVerticalOffset: 2
						shadowColor: "black"
					}
					// renderType: Text.CurveRendering


					Behavior on y {
						NumberAnimation {
							easing: Easing.OutCirc
							duration: 200
						}
					}

					Component.onCompleted: {
						console.log(realY);
					}
				}
			}
		}

	}

	NumberAnimation {
		id: closeAnim
		target: scroll
		property: "anchors.rightMargin"
		to: -window.width
		duration: 350
		easing: Easing.InCirc
	}

	Component.onCompleted: {
		window.opacity = 1.0
		scroll.anchors.rightMargin = 0
	}
}