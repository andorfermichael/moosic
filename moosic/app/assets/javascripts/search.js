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

  $(document).on("click", ".add-button", function(e) {
    console.log(e);

    renderPlaylistDiv(e);
  });
}


var resultAmount = 10;

function searchByKeyword() {
  document.getElementById('result-container').innerHTML = '';
  var keyword = $('#searchInput').val();

  youtubeRequest(keyword);
  soundcloudRequest(keyword);
}


function youtubeRequest(keyword) {
  var request = gapi.client.youtube.search.list({
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
  //console.log(response);

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
  var hostClass = document.createAttribute('class');
  hostClass.value = host;
  listItem.setAttributeNode(hostClass);

  // create thumbnail
  var tn = document.createElement('img');
  var tnClass = document.createAttribute('class');
  tnClass.value = "tn";
  var tnSrc = document.createAttribute('src');
  if(thumbnail != null) tnSrc.value = thumbnail;
  else if (host == "Yt") tnSrc.value = "/assets/yt-placeholder.png";
  else if (host == "Sc") tnSrc.value = "/assets/sc-placeholder.png";
  tn.setAttributeNode(tnSrc);
  tn.setAttributeNode(tnClass);

  // create menu-button
  var add = document.createElement('img');
  var addClass = document.createAttribute('class');
  addClass.value = "add-button";
  var addSrc = document.createAttribute('src');
  addSrc.value = "/assets/add.png";
  var idTag = document.createAttribute('data-video-id');
  idTag.value = id;
  add.setAttributeNode(addSrc);
  add.setAttributeNode(idTag);
  add.setAttributeNode(addClass);

  // create video title
  var titleSpan = document.createElement('span');
  titleSpan.appendChild(document.createTextNode(title));

  // create channel title
  var channelSpan = document.createElement('span');
  channelSpan.appendChild(document.createTextNode(channel));

  // append to listItem
  listItem.appendChild(tn);
  listItem.appendChild(add);
  listItem.appendChild(titleSpan);
  listItem.appendChild(channelSpan);

  return listItem;
}



function renderPlaylistDiv(e) {
  var div = document.createElement('div');
  var divClass = document.createAttribute('class');
  divClass.value = "playlist-popup";

  
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
