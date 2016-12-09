superagent = require 'superagent'
url        = require 'url'

_ = {
  get:   require 'lodash/get'
  map:   require 'lodash/map'
  split: require 'lodash/split'
}

resolveSrv = (hostname, callback) ->
  uri = url.format({
    protocol: 'https'
    hostname: 'dns.google.com'
    pathname: 'resolve'
    query:
      name: hostname
      type: 'SRV'
  })

  superagent
    .get uri
    .set 'Accept', 'application/json'
    .buffer true
    .end (error, result) ->
      return callback error if error?
      return _parseSrvResult result, callback

_parseSrvResult = (result, callback) ->
  return callback new Error "Unexpected error: #{result.body}" unless result.ok
  try
    body = JSON.parse(result.text)
  catch error
    return callback error
  return callback null, _.map(_.get(body, 'Answer'), _parseSrvRecord)

_parseSrvRecord = (record) ->
  [priority, weight, port, name] = _.split record.data, ' '
  return { priority, weight, port, name }


module.exports = {resolveSrv}
