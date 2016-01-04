// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

let currentPosition = 0;
let direction = 0;
let stayAtBegin = false;
let currentSong = {};

let soundcloudWidgetElement;
let soundcloudWidgetObject;
let youtubeWidgetElement;
let youtubeWidgetObject;

let prevSongButton;
let toggleSongButton;
let nextSongButton;

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
function onPlayerReady() {
  youtubeWidgetElement = document.getElementById('yt-widget');
  playSong();
}

// Fires when the player's state changes
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.ENDED) {
    // Forward, next song
    direction = 1;

    if (gon.single_track === 'false') {
      // If we are not at the end of the playlist, initiate the play of the next song
      if (currentPosition < gon.current_playlist_count_songs) {
        playSong();
      } else {
        // Go back to the begin of the playlist but do NOT initiate the play of the song
        stayAtBegin = true;
        playSong();
      }
    }

  } else if (event.data == YT.PlayerState.PAUSED) {
    toggleSongButton.classList.add('play-song');
    toggleSongButton.classList.remove('pause-song');
  } else if (event.data == YT.PlayerState.PLAYING) {
    toggleSongButton.classList.remove('play-song');
    toggleSongButton.classList.add('pause-song');
  }
}

/*
 * Calculates the current position in the playlist
 * -1 = Previous, 0 = Toggle/Special Event, 1 = Next
 */
function calcCurrentPosition() {
  if (direction == -1) {
    // Back
    if (currentPosition >= 1) {
      currentPosition--;
      sessionStorage.currentPosition = currentPosition;
    }
  } else if (direction == 1) {
    // Forward
    if (currentPosition < gon.current_playlist_count_songs) {
      currentPosition++;
      sessionStorage.currentPosition = currentPosition;
    }
  }
}

// Returns the host of the current song
function getHost() {
  if (gon.single_track === 'true') {
    return gon.current_song.host;
  } else {
    return gon.current_playlist_songs[currentPosition - 1].host;
  }
}

// Hides all available players
function hideAllPlayers() {
  soundcloudWidgetElement.style.display = 'none';
  youtubeWidgetElement.style.display = 'none';
}

// Decides which song from which host will be played
function playSong() {
  if (gon.single_track === 'true') {
    // Get the current song as object
    currentSong = gon.current_song;
  } else {
    if (stayAtBegin) {
      if (direction != 0) {
        currentPosition = 1;
      }
      sessionStorage.currentPosition = currentPosition;
    } else {
      calcCurrentPosition();
    }

    // Get the current song as object
    currentSong = gon.current_playlist_songs[currentPosition - 1];
  }

  // Decide which function has to be called
  // according to the host of the current song
  switch (getHost(currentSong)) {
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
  soundcloudWidgetElement.style.display = 'block';

  if (gon.single_track === 'true') {
    // Create the url of the song which should be played
    var newSoundUrl = 'http://api.soundcloud.com/tracks/' + gon.current_song.song_url;
  } else {
    // Create the url of the song which should be played
    var newSoundUrl = 'http://api.soundcloud.com/tracks/' + gon.current_playlist_songs[currentPosition - 1].song_url;
  }

  // Playlist is started for the first time
  if (!stayAtBegin) {
    // Let the player play the song
    soundcloudWidgetObject.bind(SC.Widget.Events.READY, function () {
      soundcloudWidgetObject.load(newSoundUrl, {
        show_artwork: true,
        auto_play: true
      });
    });
  } else { // All songs from that playlist have been played
    // Load the song but do NOT play it
    soundcloudWidgetObject.bind(SC.Widget.Events.READY, function () {
      soundcloudWidgetObject.load(newSoundUrl, {
        show_artwork: true,
        auto_play: false
      });
    });
    stayAtBegin = false;
  }

  if (gon.single_track === 'false') {
    // Fires when song finished
    soundcloudWidgetObject.bind(SC.Widget.Events.FINISH, function () {
      direction = 1;
      if (currentPosition < gon.current_playlist_count_songs) {
        playSong();
      }
    });
  }
}

// Handles the play of a song hosted by YouTube
function playYouTubeSong() {
  hideAllPlayers();
  youtubeWidgetElement.style.display = 'block';

  if (gon.single_track === 'true') {
    // Get the url of the song which should be played
    var newSoundUrl = gon.current_song.song_url;
  } else {
    // Get the url of the song which should be played
    var newSoundUrl = gon.current_playlist_songs[currentPosition - 1].song_url;
  }

  // Set the url and the quality on the player object
  youtubeWidgetObject.cueVideoById({'videoId': newSoundUrl, 'suggestedQuality': 'large'});

  // Playlist is started for the first time
  if (!stayAtBegin) {
    // Let the player play the song
    youtubeWidgetObject.playVideo()
  } else {
    stayAtBegin = false;
  }
}

function nextSong() {
  if (currentPosition < gon.current_playlist_count_songs) {
    direction = 1;
    playSong();
  }
}

function prevSong() {
  if (currentPosition > 1) {
    direction = -1;
    playSong();
  }
}

function toggleSong() {
  direction = 0;

  // Song is playing
  if (toggleSongButton.classList.contains('pause-song')) {
    if (youtubeWidgetElement.style.display == 'block') {
      youtubeWidgetObject.pauseVideo();
    } else if (soundcloudWidgetElement.style.display == 'block') {
      soundcloudWidgetObject.pause();
    }
  } else { // Song is paused
    if (youtubeWidgetElement.style.display == 'block') {
      youtubeWidgetObject.playVideo();
    } else if (soundcloudWidgetElement.style.display == 'block') {
      soundcloudWidgetObject.play();
    }
  }
}

// Adapt player size for extra small screens
function onWindowResizeEnd() {
  if ($(window).width() < 700) {
    $('#yt-widget').width(500);
    $('#yt-widget').height(260);
    $('#sc-widget').width(500);
    $('#sc-widget').height(260);
  } else {
    $('#yt-widget').width(640);
    $('#yt-widget').height(390);
    $('#sc-widget').width(640);
    $('#sc-widget').height(390);
  }
}

var doit;
window.onresize = function () {
  clearTimeout(doit);
  doit = setTimeout(onWindowResizeEnd, 100);
};

$(document).ready(function () {
  // Check if player site
  if (document.getElementById('yt-widget') != null) {
    if (gon.single_track === 'false') {
      // Tab was opened
      if (sessionStorage.currentPosition == null) {
        // Get current position from url variable
        currentPosition = gon.current_position;
        sessionStorage.currentPosition = currentPosition;
      } else { // Page was reloaded
        // Get current position from session storage
        currentPosition = sessionStorage.currentPosition;
      }
    }

    // Load the IFrame YouTube Player API code asynchronously
    const tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    const firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // Intialize the SoundCloud widget
    soundcloudWidgetElement = document.getElementById('sc-widget'), soundcloudWidgetObject = SC.Widget(soundcloudWidgetElement);

    // Add behaviour for playing a song
    // - Show pause button
    soundcloudWidgetObject.bind(SC.Widget.Events.PLAY, function () {
      toggleSongButton.classList.remove('play-song');
      toggleSongButton.classList.add('pause-song');
    });

    // Add behaviour for pausing a song
    // - Show play button
    soundcloudWidgetObject.bind(SC.Widget.Events.PAUSE, function () {
      toggleSongButton.classList.add('play-song');
      toggleSongButton.classList.remove('pause-song');
    });

    // Get control elements
    prevSongButton = document.getElementById('prev-song');
    toggleSongButton = document.getElementById('toggle-song');
    nextSongButton = document.getElementById('next-song');

    // Add event listeners to control elements
    prevSongButton.addEventListener('click', prevSong);
    toggleSongButton.addEventListener('click', toggleSong);
    nextSongButton.addEventListener('click', nextSong);

    // Do not show controls when playing single track
    if (gon.single_track === 'true') {
      $('.controls').remove();
    }
  }
});
