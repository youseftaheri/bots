class ServerAddresses {
  static const serverAddress = 'https://min-api.cryptocompare.com/data/';
  static const _candlestick = 'v2/histoday';
  static const _cubic = 'exchange/histoday';
  static const _stack = 'exchange/symbol/histoday';

  static String get candlesticks => serverAddress  + _candlestick;
  static String get cubic => serverAddress  + _cubic;
  static String get stack => serverAddress  + _stack;
  static String get webSocket => 'wss://dex.binance.org/api/ws/\$all@allTickers';
}
