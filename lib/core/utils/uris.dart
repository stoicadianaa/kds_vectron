class Uris {
  static final Uri _baseUri = Uri.parse('https://kitchen-display-screen-7c99cf02ee68.herokuapp.com');
  static final Uri _baseWssUri = _baseUri.replace(scheme: 'wss');

  static final Uri comandaWsUri = _baseWssUri.replace(path: '/ws');
  static final Uri comenziUri = _baseUri.replace(path: '/rest/comenzi/all');
  static final Uri startComandaUri = _baseUri.replace(path: '/rest/comenzi/updateStartTime');
  static final Uri endComandaUri = _baseUri.replace(path: '/rest/comenzi/updateEndTime');
}