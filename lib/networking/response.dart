class Response {
  int _statusCode;
  dynamic _object;
  Response(this._statusCode, this._object);

  dynamic get object => this._object;

  int get statusCode => this._statusCode;

}
