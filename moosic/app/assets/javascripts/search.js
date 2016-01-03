window.onload = function() {

  initializeSoundcloud()

  $('#Yt').click(function() {
    $('#Yt').addClass('active');
    $('#Sc').removeClass('active');
    $('.Sc').addClass('hidden');
    $('.Yt').removeClass('hidden');
  });

  $('#Sc').click(function() {
    $('#Sc').addClass('active');
    $('#Yt').removeClass('active');
    $('.Yt').addClass('hidden');
    $('.Sc').removeClass('hidden');
  });

}



function searchByKeyword() {
  document.getElementById('result-container').innerHTML = '';
  var keyword = $('#searchInput').val();

  youtubeRequest(keyword);
  soundcloudRequest(keyword);
}


function youtubeRequest(keyword) {
  var request = gapi.client.youtube.search.list({
    maxResults: 5,
    part: 'snippet',
    type: 'video',
    q: keyword
  });
  request.execute(generateYoutubeList);
}


function soundcloudRequest(keyword) {
  SC.get('/tracks', {
    q: keyword,
    limit: 5
  }).then(function(response) {
    generateSoundcloudList(response);
  });
}


function generateYoutubeList(response) {
  var parent = document.getElementById('result-container');

  for (var i = 0; i < response.items.length; i++) {
    var item = response.items[i];

    var listItem = generateListItem(item.id.videoId,
      item.snippet.thumbnails.medium.url,
      item.snippet.title,
      item.snippet.channelTitle,
      'Yt');

    parent.appendChild(listItem);
  };
}


function generateSoundcloudList(response) {
  var parent = document.getElementById('result-container');

  for (var i = 0; i < response.length; i++) {
    var item = response[i];

    var listItem = generateListItem(item.id,
      item.artwork_url,
      item.title,
      item.user.username,
      'Sc');

    parent.appendChild(listItem);
  };
  $('.Sc').addClass('hidden');
}


function generateListItem(id, thumbnail, title, channel, host) {
  // create list item, videoId tag and host class
  var listItem = document.createElement('li');
  var idTag = document.createAttribute('data-video-id');
  idTag.value = id;
  var hostClass = document.createAttribute('class');
  hostClass.value = host;
  listItem.setAttributeNode(idTag);
  listItem.setAttributeNode(hostClass);

  // create thumbnail
  var img = document.createElement('img');
  var src = document.createAttribute('src');
  src.value = thumbnail;
  img.setAttributeNode(src);

  // create video title
  var titleSpan = document.createElement('span');
  titleSpan.appendChild(document.createTextNode(title));

  // create channel title
  var channelSpan = document.createElement('span');
  channelSpan.appendChild(document.createTextNode(channel));

  // append to listItem
  listItem.appendChild(img);
  listItem.appendChild(titleSpan);
  listItem.appendChild(channelSpan);

  return listItem;
}


















// Youtube Api Setup functions
function onClientLoad() {
  gapi.client.load('youtube', 'v3', onYoutubeApiLoad);
}

function onYoutubeApiLoad() {
  gapi.client.setApiKey('AIzaSyCUnKMWe0bzmqB5jMasNVLfY4cYupf_auY')
}


// Soundcloud Api Setup function
function initializeSoundcloud() {
  SC.initialize({
    client_id: '030f3558914f2b95e6535c76ecf34e53'
  });
}
