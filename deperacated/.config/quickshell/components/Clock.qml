import qs.services as S
import QtQuick

Text {
    //anchors.centerIn: parent
    text: S.Time.format("hh:mm:ss")
}
