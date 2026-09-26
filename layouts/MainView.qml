import QtQuick
import QtQuick.Controls
import QtQuick.Window

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


		    Repeater {
		    	model: appList


		    	delegate: Text {
		    		text: model.name
		    		// anchors.right: parent.right
		    		font.pixelSize: 15

		    		// property real realY: mapToItem(null, 0, 0).y;
		    		property real realY: scroll.y + y - scroll.contentY;

		    		// y: ( index * 20 ) + (parent.height / 2)
		    		y: ( index - ( 5 - 1 ) / 2 ) * 20 + scroll.height / 2

		    		x: ( 0.002 * Math.pow(realY - (window.height / 2), 2) ) + scroll.width - width - 20

		    		Component.onCompleted: {
		    			console.log(realY);
		    		}
		    	}
		    }
	    }

    }
}