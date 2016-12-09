# http-dns
Node DNS library that uses Google's HTTPS DNS API for doing queries in the browser

# NOTE: only resolveSrv is supported at this time

## dns.resolveSrv(hostname, callback)

Uses the DNS protocol to resolve service records (SRV records) for the hostname. The addresses argument passed to the callback function will be an array of objects with the following properties:

* priority
* weight
* port
* name

```javascript
{
  priority: 10,
  weight: 5,
  port: 21223,
  name: 'service.example.com'
}
```
