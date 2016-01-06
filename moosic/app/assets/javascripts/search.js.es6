window.onload = function () {

  initializeSoundcloud();

  $('#Yt').click(function () {
    $('#playlists').removeClass('active');
    $('#users').removeClass('active');
    $('#tracks').addClass('active');
    $('#Yt').addClass('active');
    $('#Sc').removeClass('active');
    $('.Sc').addClass('hidden');
    $('.Yt').removeClass('hidden');

    searchByKeyword();
  });

  $('#Sc').click(function () {
    $('#playlists').removeClass('active');
    $('#users').removeClass('active');
    $('#tracks').addClass('active');
    $('#Sc').addClass('active');
    $('#Yt').removeClass('active');
    $('.Yt').addClass('hidden');
    $('.Sc').removeClass('hidden');

  });

  $('#users').click(function () {
    $('#playlists').removeClass('active');
    $('#tracks').removeClass('active');
    $('#Yt').removeClass('active');
    $('#Sc').removeClass('active');
    $('#users').addClass('active');
  });

  $('#playlists').click(function () {
    $('#users').removeClass('active');
    $('#tracks').removeClass('active');
    $('#Yt').removeClass('active');
    $('#Sc').removeClass('active');
    $('#playlists').addClass('active');
  });

  $('.cancel').click(function () {
    $('.playlist-popup').addClass('hidden');
  });

  $(document).on('click', '.add-button', function (e) {
    $('.playlist-popup').removeClass('hidden');
    tempObj = e.target.parentElement;
  });

  $('.pl').click(function (e) {
    const elems = tempObj.childNodes;

    if (tempObj.className == 'Yt')  {
      var host = 'youtube';
    } else { 
      var host = 'soundcloud';
    }

    $.ajax({
      url: 'add_to_playlist',
      type: 'GET',
      data: {
        "title": elems[2].innerText,
        "source": elems[3].innerText,
        "thumbnail_url": 'https://i.ytimg.com/vi/' + tempObj.dataset.video_id + '/mqdefault.jpg',
        "song_url": tempObj.dataset.video_id,
        "host": host,
        "playlist_id": e.target.dataset.playlist_id
      },
      success: function (data) {
        alert('Successfully added to Playlist.')
      },
      error: function (data) {
        alert('Failed to add song to Playlist.');
      }
    });

    $('.playlist-popup').addClass('hidden');
  });
}

let tempObj;
const resultAmount = 10;

function searchByKeyword() {
  document.getElementById('result-container').innerHTML = '';
  const keyword = $('#search_input').val();

  youtubeRequest(keyword);
  soundcloudRequest(keyword);
}

function youtubeRequest(keyword) {
  let request = gapi.client.youtube.search.list({
    maxResults: resultAmount,
    part: 'snippet',
    type: 'video',
    q: keyword
  });
  request.execute(generateYoutubeList);
}

function soundcloudRequest(keyword) {
  SC.get('/tracks', {
    q: keyword,
    limit: resultAmount
  }).then(function (response) {
    generateSoundcloudList(response);
  });
}

function generateYoutubeList(response) {
  const parent = document.getElementById('result-container');

  for (let i = 0; i < response.items.length; i++) {
    let item = response.items[i];

    let listItem = generateListItem (
      item.id.videoId,
      item.snippet.thumbnails.medium.url,
      item.snippet.title,
      item.snippet.channelTitle,
      'Yt'
    );

    parent.appendChild(listItem);
  }
}

function generateSoundcloudList(response) {
  const parent = document.getElementById('result-container');

  for (let i = 0; i < response.length; i++) {
    let item = response[i];

    let listItem = generateListItem (
      item.id,
      item.artwork_url,
      item.title,
      item.user.username,
      'Sc'
    );

    parent.appendChild(listItem);
  }

  $('.Sc').addClass('hidden');
}

function generateListItem(id, thumbnail, title, channel, host) {
  // Create list item, videoId tag and host class
  const listItem = document.createElement('li');
  const hostClass = document.createAttribute('class');
  hostClass.value = host;
  const idTag = document.createAttribute('data-video_id');
  idTag.value = id;
  listItem.setAttributeNode(idTag);
  listItem.setAttributeNode(hostClass);

  // Create thumbnail
  const tn = document.createElement('img');
  const tnClass = document.createAttribute('class');
  tnClass.value = 'tn';
  const tnSrc = document.createAttribute('src');

  if (thumbnail != null) {
    tnSrc.value = thumbnail;
  } else if (host == 'Yt') {
    tnSrc.value = '/assets/yt-placeholder.png';
  } else if (host == "Sc") {
    tnSrc.value = '/assets/sc-placeholder.png';
  }

  tn.setAttributeNode(tnSrc);
  tn.setAttributeNode(tnClass);

  // Create menu-button
  const add = document.createElement('img');
  const addClass = document.createAttribute('class');
  addClass.value = 'add-button';
  const addSrc = document.createAttribute('src');
  addSrc.value = '/assets/add.png';
  add.setAttributeNode(addSrc);
  add.setAttributeNode(addClass);

  // Create video title
  const titleSpan = document.createElement('span');
  titleSpan.appendChild(document.createTextNode(title));

  // Create channel title
  const channelSpan = document.createElement('span');
  channelSpan.appendChild(document.createTextNode(channel));

  // Append to listItem
  listItem.appendChild(tn);
  listItem.appendChild(add);
  listItem.appendChild(titleSpan);
  listItem.appendChild(channelSpan);

  return listItem;
}

// Youtube Api Setup functions
function onClientLoad() {
  gapi.client.load('youtube', 'v3', onYoutubeApiLoad);
}

function onYoutubeApiLoad() {
  gapi.client.setApiKey('AIzaSyCUnKMWe0bzmqB5jMasNVLfY4cYupf_auY');
}

// Soundcloud Api Setup function
function initializeSoundcloud() {
  SC.initialize({
    client_id: '030f3558914f2b95e6535c76ecf34e53'
  });
}
