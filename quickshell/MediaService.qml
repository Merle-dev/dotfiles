import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Mpris
import "../helpers"

pragma Singleton

Singleton {
    id: root

    property alias activePlayer: instance.activePlayer
    property bool isPlaying: activePlayer ? activePlayer.playbackState === MprisPlaybackState.Playing : false

    property string title: activePlayer ? activePlayer.trackTitle : "No Media"
    property string artist: activePlayer ? activePlayer.trackArtist : ""
    property string album: activePlayer ? activePlayer.trackAlbum : ""
    property string artUrl: activePlayer ? activePlayer.trackArtUrl : ""

    property double position: 0
    property double length: activePlayer ? activePlayer.length : 0

    property string trackId

    property var _players: Mpris.players.values
    property int playerCount: _players.length

    property string currentPlayerName:
        activePlayer ? (activePlayer.identity || activePlayer.desktopEntry || "Unknown") : ""

    property bool manualSelection: false

    function setPosition(pos) {
        if (activePlayer)
            activePlayer.position = pos;
    }

    function playPause() {
        if (activePlayer && activePlayer.canTogglePlaying)
            activePlayer.togglePlaying();
    }

    function next() {
        if (activePlayer && activePlayer.canGoNext)
            activePlayer.next();
    }

    function previous() {
        if (activePlayer && activePlayer.canGoPrevious)
            activePlayer.previous();
    }

    function selectPlayer(player) {
        if (player) {
            instance.activePlayer = player;
            manualSelection = true;
        }
    }

    function nextPlayer() {
        const players = Mpris.players.values;
        if (players.length <= 1) return;
        const idx = players.indexOf(instance.activePlayer);
        selectPlayer(players[(idx + 1) % players.length]);
    }

    function previousPlayer() {
        const players = Mpris.players.values;
        if (players.length <= 1) return;
        const idx = players.indexOf(instance.activePlayer);
        selectPlayer(players[(idx - 1 + players.length) % players.length]);
    }

    function updateActivePlayer() {
        const players = Mpris.players.values;

        if (manualSelection && instance.activePlayer && players.includes(instance.activePlayer))
            return;

        if (manualSelection && instance.activePlayer && !players.includes(instance.activePlayer))
            manualSelection = false;

        const playing = players.find(p => p.playbackState === MprisPlaybackState.Playing);

        if (playing) {
            instance.activePlayer = playing;
        } else if (players.length > 0) {
            if (!instance.activePlayer || !players.includes(instance.activePlayer))
                instance.activePlayer = players[0];
        } else {
            instance.activePlayer = null;
        }
    }

    Component.onCompleted: {
        updateActivePlayer()
    }

    QtObject {
        id: instance
        property var players: Mpris.players.values
        property var activePlayer: null
    }

    // Update position every second
    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            updateActivePlayer();

            if (activePlayer)
                root.position = activePlayer.position;
                root.length = activePlayer.length
                root.artUrl = activePlayer.trackArtUrl
            trackIdProcess.running = true
        }
    }

    // Detect player list changes
    Connections {
        target: Mpris.players

        function onValuesChanged() {
            root._players = Mpris.players.values;
            updateActivePlayer();
        }
    }
    Process {
        id: trackIdProcess
    }
}
