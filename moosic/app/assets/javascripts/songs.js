// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentPosition;
var direction = 0;
var stayAtBegin = false;
var soundcloudWidget;
var youtubeWidgetElement;
var youtubeWidgetObject;

// Creates an <iframe> (and YouTube player) after the API code downloads
function onYouTubeIframeAPIReady() {
    youtubeWidgetObject = new YT.Player('yt-widget', {
        height: '390',
        width: '640',
        videoId: '',
        playerVars: {
            autoplay: 0,
            fs: false,
            rel: 0
        },
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

// Fires when the video player is ready
function onPlayerReady(event) {
    youtubeWidgetElement = document.getElementById('yt-widget');
    playSong();
}

// Fires when the player's state changes
function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.ENDED) {
        // Forward, next song
        direction = 1;

        // If we are not at the end of the playlist,
        // initiate the play of the next song
        if (currentPosition < gon.current_playlist_count_songs) {
            playSong();
        }
        else { // Go back to the begin of the playlist but do NOT initiate the play of the song
            stayAtBegin = true;
            playSong();
        }
    }
}

// Calculates the current position in the playlist
// -1 = Back, 0 = First Song of Playlist, 1 = Forward
function calcCurrentPosition() {
    // Back
    if (direction == -1) {
        if (currentPosition >= 1) {
            currentPosition--;
            sessionStorage.currentPosition = currentPosition;
        }
    } // Forward
    else if (direction == 1) {
        if (currentPosition < gon.current_playlist_count_songs) {
            currentPosition++;
            sessionStorage.currentPosition = currentPosition;
        }
    }
}

// Returns the host of the current song
function getHost() {
    return gon.current_playlist_songs[currentPosition - 1].host;
}

// Hides all available players
function hideAllPlayers() {
    soundcloudWidget.style.display = 'none';
    youtubeWidgetElement.style.display = 'none';
}

// Decides which song from which host will be played
function playSong() {
    if (stayAtBegin) {
        currentPosition = 1;
        sessionStorage.currentPosition = currentPosition;
    } else {
        calcCurrentPosition();
    }

    // Get the current song as object
    var currentSong = gon.current_playlist_songs[currentPosition - 1];

    // Decide which function has to be called
    // according to the host of the current song
    switch(getHost(currentSong)) {
        case 'youtube':
            playYouTubeSong();
            break;
        case 'soundcloud':
            playSoundCloudSong();
            break;
    }
}

// Handles the play of a song hosted by SoundCloud
function playSoundCloudSong() {
    hideAllPlayers();
    soundcloudWidget.style.display = 'block';

    // Create the url of the song which should be played
    var newSoundUrl = 'http://api.soundcloud.com/tracks/' + gon.current_playlist_songs[currentPosition - 1].song_url;

    // Playlist is either started for the first time
    // or we are not at the end of the playlist
    if (!stayAtBegin) {
        // Let the player play the song
        widget.bind(SC.Widget.Events.READY, function() {
            widget.load(newSoundUrl, {
                show_artwork: true,
                auto_play: true
            });
        });
    } else {
        // Load the song but do NOT play it
        widget.bind(SC.Widget.Events.READY, function() {
            widget.load(newSoundUrl, {
                show_artwork: true,
                auto_play: false
            });
        });
        stayAtBegin = false;
    }

    // Fires when song finished
    widget.bind(SC.Widget.Events.FINISH, function() {
        direction = 1;
        if (currentPosition < gon.current_playlist_count_songs) {
            playSong();
        }
    });
}

// Handles the play of a song hosted by YouTube
function playYouTubeSong() {
    hideAllPlayers();
    youtubeWidgetElement.style.display = 'block';

    // Get the url of the song which should be played
    var newSoundUrl = gon.current_playlist_songs[currentPosition - 1].song_url;

    // Set the url and the quality on the player object
    youtubeWidgetObject.cueVideoById({'videoId': newSoundUrl, 'suggestedQuality': 'large'});

    // Playlist is either started for the first time
    // or we are not at the end of the playlist
    if (!stayAtBegin) {
        // Let the player play the song
        youtubeWidgetObject.playVideo()
    } else {
        stayAtBegin = false;
    }
}

$(document).ready(function() {
    // Check if player site
    if (document.getElementById('yt-widget') != null) {

        // Tab was opened
        if (sessionStorage.currentPosition == null) {
            // Get current position from url variable
            currentPosition = gon.current_position;
            sessionStorage.currentPosition = currentPosition;
        } else { // Page was reloaded
            // Get current position from session storage
            currentPosition = sessionStorage.currentPosition;
        }

        // Load the IFrame YouTube Player API code asynchronously
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

        // Intialize the SoundCloud widget
        soundcloudWidget = document.getElementById('sc-widget'), widget = SC.Widget(soundcloudWidget);
    }
});
