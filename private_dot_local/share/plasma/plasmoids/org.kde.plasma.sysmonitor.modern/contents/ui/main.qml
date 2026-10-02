import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    // Default widget dimensions
    width: 320
    height: 670

    // Set background hints to configurable (allows custom transparency/blur container support)
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

    // Data properties
    property real cpuUsage: 0.0
    property real cpuTemp: 0.0
    property real ramUsed: 0.0
    property real ramTotal: 16.0
    property real ramPct: 0.0
    property real gpuUsage: 0.0
    property real gpuTemp: 0.0
    property real vramUsed: 0.0
    property real vramTotal: 8.0
    property real vramPct: 0.0
    property string netDownSpeed: "0 B/s"
    property string netUpSpeed: "0 B/s"

    // Network speed history buffers for wave charts (30 data points)
    property var netDownHistory: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property var netUpHistory: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    // DataSource execution wrapper using compatibility layer for shell runner
    Plasma5Support.DataSource {
        id: dbusSource
        engine: "executable"
        connectedSources: []
        
        onNewData: (sourceName, data) => {
            disconnectSource(sourceName); // Unbind source to allow consecutive runs
            var stdout = data["stdout"];
            if (stdout) {
                try {
                    var stats = JSON.parse(stdout.trim());
                    root.updateStats(stats);
                } catch (e) {
                    console.log("JSON parsing error: " + e);
                }
            }
        }
        
        function fetch() {
            var scriptPath = Qt.resolvedUrl("data.py").toString();
            if (scriptPath.indexOf("file://") === 0) {
                scriptPath = scriptPath.substring(7);
            }
            connectSource(scriptPath);
        }
    }

    // Interval timer for low-overhead update polling (2.0s interval)
    Timer {
        id: updateTimer
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            dbusSource.fetch();
        }
    }

    function updateStats(stats) {
        root.cpuUsage = stats.cpu_usage !== undefined ? stats.cpu_usage : 0.0;
        root.cpuTemp = stats.cpu_temp !== undefined ? stats.cpu_temp : 0.0;
        root.ramUsed = stats.ram_used_gb !== undefined ? stats.ram_used_gb : 0.0;
        root.ramTotal = stats.ram_total_gb !== undefined ? stats.ram_total_gb : 16.0;
        root.ramPct = stats.ram_pct !== undefined ? stats.ram_pct : 0.0;
        root.gpuUsage = stats.gpu_usage !== undefined ? stats.gpu_usage : 0.0;
        root.gpuTemp = stats.gpu_temp !== undefined ? stats.gpu_temp : 0.0;
        root.vramUsed = stats.vram_used_gb !== undefined ? stats.vram_used_gb : 0.0;
        root.vramTotal = stats.vram_total_gb !== undefined ? stats.vram_total_gb : 8.0;
        root.vramPct = stats.vram_pct !== undefined ? stats.vram_pct : 0.0;
        root.netDownSpeed = stats.net_down_formatted !== undefined ? stats.net_down_formatted : "0 B/s";
        root.netUpSpeed = stats.net_up_formatted !== undefined ? stats.net_up_formatted : "0 B/s";

        var downVal = stats.net_down_speed || 0.0;
        var upVal = stats.net_up_speed || 0.0;

        // Use slice() to create a copy of the array so QML binding detects reference change
        var downHist = root.netDownHistory.slice();
        downHist.push(downVal);
        if (downHist.length > 30) downHist.shift();
        root.netDownHistory = downHist;

        var upHist = root.netUpHistory.slice();
        upHist.push(upVal);
        if (upHist.length > 30) upHist.shift();
        root.netUpHistory = upHist;
    }

    Component.onCompleted: {
        dbusSource.fetch();
    }

    fullRepresentation: Item {
        Layout.minimumWidth: 280
        Layout.minimumHeight: 600
        Layout.preferredWidth: 320
        Layout.preferredHeight: 670

        // Custom Glassmorphic background container
        Rectangle {
            id: mainContainer
            anchors.fill: parent
            color: Qt.rgba(0.08, 0.11, 0.16, 0.22) // High transparency (0.42 -> 0.22)
            radius: 14
            border.color: Qt.rgba(1.0, 1.0, 1.0, 0.12) // Delicate border highlight
            border.width: 1

            // Cyberpunk micro-glow inner border
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: "transparent"
                radius: 13
                border.color: Qt.rgba(0.0, 0.94, 1.0, 0.04)
                border.width: 1
            }
        }

        // Widget UI Column Layout
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            // Header Section
            RowLayout {
                Layout.fillWidth: true
                
                Text {
                    text: "System Monitor"
                    color: "#ffffff"
                    font.pixelSize: 18
                    font.weight: Font.Light
                    font.family: "Inter, Outfit, Noto Sans, Helvetica Neue, Arial, sans-serif"
                    Layout.fillWidth: true
                }
                
                Text {
                    text: "⚙" // Unicode Cog Icon
                    color: "#a0aec0"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignRight
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "#00f0ff"
                        onExited: parent.color = "#a0aec0"
                        onClicked: {
                            dbusSource.fetch(); // Trigger immediate update on click
                        }
                    }
                }
            }

            // Divider Line
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1.0, 1.0, 1.0, 0.08)
            }

            // 1. Network Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 145
                color: Qt.rgba(1.0, 1.0, 1.0, 0.02)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.06)
                border.width: 1
                radius: 8
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 4
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Kirigami.Icon {
                            source: "network-wired"
                            implicitWidth: 14
                            implicitHeight: 14
                            color: "#00f0ff"
                        }
                        Text {
                            text: "NETWORK"
                            color: "#00f0ff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Download:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                        Text {
                            text: root.netDownSpeed
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    Canvas {
                        id: downCanvas
                        Layout.fillWidth: true
                        Layout.preferredHeight: 32
                        property var history: root.netDownHistory
                        onHistoryChanged: requestPaint()
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();
                            ctx.clearRect(0, 0, width, height);
                            if (history.length < 2) return;
                            var maxVal = 10 * 1024; // 10 KB/s baseline minimum scale for active waves
                            for (var i = 0; i < history.length; i++) {
                                if (history[i] > maxVal) maxVal = history[i];
                            }
                            ctx.lineWidth = 1.5;
                            ctx.strokeStyle = "#00f0ff";
                            var grad = ctx.createLinearGradient(0, 0, 0, height);
                            grad.addColorStop(0, Qt.rgba(0.0, 0.94, 1.0, 0.15));
                            grad.addColorStop(1, Qt.rgba(0.0, 0.94, 1.0, 0.0));
                            ctx.fillStyle = grad;
                            ctx.beginPath();
                            var dx = width / (history.length - 1);
                            ctx.moveTo(0, height - (history[0] / maxVal) * (height - 4) - 2);
                            for (var j = 1; j < history.length; j++) {
                                var x = j * dx;
                                var y = height - (history[j] / maxVal) * (height - 4) - 2;
                                var prevX = (j - 1) * dx;
                                var prevY = height - (history[j - 1] / maxVal) * (height - 4) - 2;
                                ctx.bezierCurveTo(prevX + dx/2, prevY, prevX + dx/2, y, x, y);
                            }
                            ctx.stroke();
                            ctx.lineTo(width, height);
                            ctx.lineTo(0, height);
                            ctx.closePath();
                            ctx.fill();
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Upload:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                        Text {
                            text: root.netUpSpeed
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    Canvas {
                        id: upCanvas
                        Layout.fillWidth: true
                        Layout.preferredHeight: 20
                        property var history: root.netUpHistory
                        onHistoryChanged: requestPaint()
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();
                            ctx.clearRect(0, 0, width, height);
                            if (history.length < 2) return;
                            var maxVal = 10 * 1024; // 10 KB/s baseline minimum scale for active waves
                            for (var i = 0; i < history.length; i++) {
                                if (history[i] > maxVal) maxVal = history[i];
                            }
                            ctx.lineWidth = 1.5;
                            ctx.strokeStyle = "#00f0ff";
                            var grad = ctx.createLinearGradient(0, 0, 0, height);
                            grad.addColorStop(0, Qt.rgba(0.0, 0.94, 1.0, 0.15));
                            grad.addColorStop(1, Qt.rgba(0.0, 0.94, 1.0, 0.0));
                            ctx.fillStyle = grad;
                            ctx.beginPath();
                            var dx = width / (history.length - 1);
                            ctx.moveTo(0, height - (history[0] / maxVal) * (height - 4) - 2);
                            for (var j = 1; j < history.length; j++) {
                                var x = j * dx;
                                var y = height - (history[j] / maxVal) * (height - 4) - 2;
                                var prevX = (j - 1) * dx;
                                var prevY = height - (history[j - 1] / maxVal) * (height - 4) - 2;
                                ctx.bezierCurveTo(prevX + dx/2, prevY, prevX + dx/2, y, x, y);
                            }
                            ctx.stroke();
                            ctx.lineTo(width, height);
                            ctx.lineTo(0, height);
                            ctx.closePath();
                            ctx.fill();
                        }
                    }
                }
            }

            // 2. CPU Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: Qt.rgba(1.0, 1.0, 1.0, 0.02)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.06)
                border.width: 1
                radius: 8
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 6
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Kirigami.Icon {
                            source: "cpu"
                            implicitWidth: 14
                            implicitHeight: 14
                            color: "#00f0ff"
                        }
                        Text {
                            text: "CPU"
                            color: "#00f0ff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Usage:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.preferredWidth: 40
                        }
                        
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 8
                            spacing: 3
                            
                            Repeater {
                                model: 20
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 1.5
                                    color: index < Math.round((root.cpuUsage / 100.0) * 20)
                                           ? "#00f0ff"
                                           : Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                    Behavior on color { ColorAnimation { duration: 150 } }
                                }
                            }
                        }
                        
                        Text {
                            text: Math.round(root.cpuUsage) + "%"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredWidth: 35
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Temp:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.preferredWidth: 40
                        }
                        
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 6
                            
                            Rectangle {
                                anchors.fill: parent
                                color: Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                radius: 3
                            }
                            
                            Rectangle {
                                width: Math.max(0, parent.width * (Math.min(100.0, root.cpuTemp) / 100.0))
                                height: parent.height
                                radius: 3
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#00f0ff" } // Cyan
                                    GradientStop { position: 0.7; color: "#ff9f00" } // Orange
                                    GradientStop { position: 1.0; color: "#ff007f" } // Red/Pink
                                }
                                Behavior on width { NumberAnimation { duration: 250 } }
                            }
                        }
                        
                        Text {
                            text: Math.round(root.cpuTemp) + "°C"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredWidth: 35
                        }
                    }
                }
            }

            // 3. RAM Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: Qt.rgba(1.0, 1.0, 1.0, 0.02)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.06)
                border.width: 1
                radius: 8
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 6
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Kirigami.Icon {
                            source: "memory"
                            implicitWidth: 14
                            implicitHeight: 14
                            color: "#00f0ff"
                        }
                        Text {
                            text: "RAM"
                            color: "#00f0ff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Usage: " + root.ramUsed.toFixed(1) + " GB / " + root.ramTotal.toFixed(0) + " GB"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                        Text {
                            text: Math.round(root.ramPct) + "%"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 8
                        spacing: 2
                        
                        Repeater {
                            model: 26
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 1.5
                                color: index < Math.round((root.ramPct / 100.0) * 26)
                                       ? "#00f0ff"
                                       : Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }
                        }
                    }
                }
            }

            // 4. GPU Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: Qt.rgba(1.0, 1.0, 1.0, 0.02)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.06)
                border.width: 1
                radius: 8
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 6
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Kirigami.Icon {
                            source: "video-card"
                            implicitWidth: 14
                            implicitHeight: 14
                            color: "#00f0ff"
                        }
                        Text {
                            text: "GPU"
                            color: "#00f0ff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Usage:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.preferredWidth: 40
                        }
                        
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 8
                            spacing: 3
                            
                            Repeater {
                                model: 20
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 1.5
                                    color: index < Math.round((root.gpuUsage / 100.0) * 20)
                                           ? "#00f0ff"
                                           : Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                    Behavior on color { ColorAnimation { duration: 150 } }
                                }
                            }
                        }
                        
                        Text {
                            text: Math.round(root.gpuUsage) + "%"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredWidth: 35
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Temp:"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.preferredWidth: 40
                        }
                        
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 6
                            
                            Rectangle {
                                anchors.fill: parent
                                color: Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                radius: 3
                            }
                            
                            Rectangle {
                                width: Math.max(0, parent.width * (Math.min(100.0, root.gpuTemp) / 100.0))
                                height: parent.height
                                radius: 3
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#00f0ff" }
                                    GradientStop { position: 0.7; color: "#ff9f00" }
                                    GradientStop { position: 1.0; color: "#ff007f" }
                                }
                                Behavior on width { NumberAnimation { duration: 250 } }
                            }
                        }
                        
                        Text {
                            text: Math.round(root.gpuTemp) + "°C"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredWidth: 35
                        }
                    }
                }
            }

            // 5. VRAM Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                color: Qt.rgba(1.0, 1.0, 1.0, 0.02)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.06)
                border.width: 1
                radius: 8
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 6
                    
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Kirigami.Icon {
                            source: "video-card"
                            implicitWidth: 14
                            implicitHeight: 14
                            color: "#00f0ff"
                        }
                        Text {
                            text: "VRAM"
                            color: "#00f0ff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Text {
                            text: "Usage: " + root.vramUsed.toFixed(1) + " GB / " + root.vramTotal.toFixed(0) + " GB"
                            color: "#a0aec0"
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                        }
                        Text {
                            text: Math.round(root.vramPct) + "%"
                            color: "#ffffff"
                            font.bold: true
                            font.pixelSize: 11
                            font.family: "Noto Sans, Arial, sans-serif"
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 8
                        spacing: 3
                        
                        Repeater {
                            model: 20
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 1.5
                                color: index < Math.round((root.vramPct / 100.0) * 20)
                                       ? "#00f0ff"
                                       : Qt.rgba(1.0, 1.0, 1.0, 0.12)
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }
                        }
                    }
                }
            }
        }
    }
}
