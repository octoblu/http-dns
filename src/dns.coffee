superagent = require 'superagent'

Helper = require './helper'
Srv    = require './srv'

class Dns
  @DNS_HTTP_SERVER: 'https://dns.google.com'

  @resolveSrv: (hostname, callback) ->
    superagent
      .get Helper.url(baseUrl: Dns.DNS_HTTP_SERVER, name: hostname, type: 'SRV')
      .set 'Accept', 'application/json'
      .buffer true
      .end (error, result) ->
        return callback error if error?
        return Srv.parseResult result, callback
    return # no promises

module.exports = Dns
