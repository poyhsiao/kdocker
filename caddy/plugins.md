# Available plugins:

## Directives/Middleware
Extra functionality with the Caddyfile

---

### dyndns

Using cloudflare.com or pdd.yandex.ru as in dynamic dns mode

### http.authz

Caddy-authz is an authorization middleware for Caddy, it's based on https://github.com/casbin/casbin.

Casbin is a powerful and efficient open-source access control library for Golang projects. It provides support for enforcing authorization based on various models like ACL, RBAC, ABAC.

### http.awses

Caddy plugin for signing and proxying requests to AWS Elasticsearch (AWS ES).

Configuring access to an AWS ES domain can be tricky. The access policy of an AWS ES domain is based on a principal (which necessitates a signed request) or an IP address whitelist. Whitelisting IP addresses often isn't a viable option and standard tools (such as curl or a browser) can't properly sign requests.

This is exactly the problem this plugin aims to address. Standard tools can make unauthenticated requests to the Caddy server which are then signed and proxied to the AWS ES service.

### http.awslambda

The awslambda plugin gateways requests to AWS Lambda functions.

### http.cache

The cache directive adds http caching

### http.cgi

This plugin implements the Common Gateway Interface (CGI) for Caddy. It lets you generate dynamic content on your website by means of command line scripts. To collect information about the inbound HTTP request, your script examines certain environment variables such as PATH_INFO and QUERY_STRING. Then, to return a dynamically generated web page to the client, your script simply writes content to standard output. In the case of POST requests, your script reads additional inbound content from standard input.

### http.cors

Supports Cross Origin Resource Sharing headers

### http.datadog

Datadog plugin allow Caddy HTTP/2 web server to send some metrics to Datadog.

This plugin is not only working with Datadog, it also compatible with all services using statsd.

### http.expires

expires allows you to set expiration header relative to the request time. It allows you to set different expiration durations base on a path matching a regular expression.

### http.filemanager

filemanager is an extension based on browse middleware. It provides a file managing interface within the specified directory and it can be used to upload, delete, preview and rename your files within that directory.

If you are having troubles **handling large files** you might need to check out the timeouts plugin, which can be used to change the default HTTP Timeouts.

### http.forwardproxy

Enables Caddy webserver to act as a Secure Web Proxy. Effectively, forwards HTTP requests in following form: GET someplace.else/thing.html HTTP/1.1 and establishes secure TCP tunnels for: CONNECT someotherweb.server HTTP/1.1

HTTP/2.0 is supported and highly recommended, as it enables multiplexing.

### http.git

The git plugin makes it possible to deploy your site with a simple git push.

The git directive starts a service routine that runs during the lifetime of the server. When the service starts, it clones the repository. While the server is still up, it pulls the latest every so often. You can also set up a webhook to pull immediately after a push. In regular git fashion, a pull only includes changes, so it is very efficient.

### http.gopkg

The gopkg directive allows you to create vanity Go import urls.

### http.grpc

The Caddy grpc plugin proxies gRPC calls from clients to gRPC servies. It makes it possible for gRPC services to be consumed from normal gRPC clients or from browsers (using the gRPC-Web protocol).

### http.hugo

hugo fills the gap between Hugo and the browser. Hugo is an easy and fast static website generator. This plugin fills the gap between Hugo and the end-user, providing you an web interface to manage the whole website.

Using this plugin, you won't need to have your own computer to edit posts, neither regenerate your static website, because you can do all of that just through your browser.

**Requirements**: you need to have the hugo executable in your ***PATH***. You can download it from its official page.

### http.ipfilter

The ipfilter directive adds the ability to allow or block requests based on the client's IP address.

### http.jekyll

The jekyll directive fills the gap between Jekyll and the end-user, providing you an web interface to manage your whole website.

**Requirements**: you need to have Jekyll in your ***PATH***. You can download it from its official page.

### http.jwt

This middleware implements an authorization layer for Caddy based on JSON Web Tokens (JWT).

### http.locale

Locale detection for caddy

### http.login

Login directive for Caddy, based on github.com/tarent/loginsrv. The login is checked against a backend and then returned as JWT token. This directive is designed to play together with the http.jwt middleware.

The following providers (login backends) are supported:

- Htpasswd
- OSIAM
- Simple (user/password pairs by configuration)
- Github, Google OAuth2 Login

### http.mailout

mailout - a SMTP client email middleware with PGP encryption. Post form data from your website to your defined endpoint and receive the posted data as nicely formatted or even encrypted email.

### http.minify

Minify static assets on-the-fly. Supports CSS, HTML, JS, JSON, SVG and XML.

### http.nobots

Nobots protect your website against web crawlers and bots.

### http.prometheus

This directive enables prometheus metrics for Caddy.

### http.proxyprotocol

This directive enables PROXY protocol (v1) support to Caddy.

The PROXY PROTOCOL allows the client IP to be passed through a load balancer like those used in AWS or Google Cloud.

### http.ratelimit

ratelimit is used to limit the request processing rate based on client's IP address. Excessive requests will be terminated with an error 429 (Too Many Requests) and X-RateLimit-RetryAfter header will be returned.

### http.realip

This plugin allows you to see the actual client IP from ***X-Forwarded-For*** headers if you are running behind a CDN or Proxy. It will make it so logs and other downstream directives will see the actual client IP, not the proxy's.

Implements security measures so that X-Forwarded-For cannot be spoofed from unauthorized IP ranges.

### http.reauth

A common basis for authenticating with various and multiple authentication systems.

This came to be as we wanted to dynamically authenticate our docker registry against gitlab-ci and avoid storing credentials in gitlab while still permitting users to log in with their own credentials.

### http.restic

The restic plugin serves a restic repository at a path. Restic is a secure and fast backup program, see https://restic.github.io for details

### http.upload

Upload files using an API and HTTP method POST or PUT.

Handy for uploads of the likes of build artifacts, downloads-to-be, or the odd file using tools like curl.

### http.webdav

WebDAV capabilities with support for path restriction rules and users.

---

## DNS Providers
Obtain certificates using DNS

---

### tls.dns.auroradns

Allows you to obtain certificates using DNS records for domains managed with AuroraDNS.

### tls.dns.azure

Allows you to obtain certificates using DNS records for domains managed with Microsoft Azure.

### tls.dns.cloudflare

Allows you to obtain certificates using DNS records for domains managed with Cloudflare.

### tls.dns.cloudxns

Allows you to obtain certificates using DNS records for domains managed with CloudXNS.

### tls.dns.digitalocean

Allows you to obtain certificates using DNS records for domains managed with DigitalOcean.

### tls.dns.dnsimple

Allows you to obtain certificates using DNS records for domains managed with DNSimple.

### tls.dns.dnsmadeeasy

Allows you to obtain certificates using DNS records for domains managed with DNS Made Easy.

### tls.dns.dnspod

Allows you to obtain certificates using DNS records for domains managed with DNSPod.

### tls.dns.dyn

Allows you to obtain certificates using DNS records for domains managed with Dyn.

### tls.dns.exoscale

Allows you to obtain certificates using DNS records for domains managed with Exoscale.

### tls.dns.gandi

Allows you to obtain certificates using DNS records for domains managed with Gandi.

### tls.dns.gandiv5

Allows you to obtain certificates using DNS records for domains managed with Gandi v5.

### tls.dns.godaddy

Allows you to obtain certificates using DNS records for domains managed with GoDaddy.

### tls.dns.googlecloud

Allows you to obtain certificates using DNS records for domains managed with Google Cloud.

### tls.dns.lightsail

Allows you to obtain certificates using DNS records for domains managed with AWS Lightsail.

### tls.dns.linode

Allows you to obtain certificates using DNS records for domains managed with Linode.

### tls.dns.namecheap

Allows you to obtain certificates using DNS records for domains managed with NameCheap.

### tls.dns.ns1

Allows you to obtain certificates using DNS records for domains managed with NS1.

### tls.dns.otc

Allows you to obtain certificates using DNS records for domains managed with Open Telekom Cloud Managed DNS.

### tls.dns.ovh

Allows you to obtain certificates using DNS records for domains managed with OVH.

### tls.dns.powerdns

Allows you to obtain certificates using DNS records for domains managed with PowerDNS.

### tls.dns.rackspace

Allows you to obtain certificates using DNS records for domains managed with Rackspace.

### tls.dns.rfc2136

Allows you to obtain certificates using DNS records for domains managed with any RFC 2136 compliant DNS provider.

### tls.dns.route53

Allows you to obtain certificates using DNS records for domains managed with Amazon Route53.

### tls.dns.vultr

Allows you to obtain certificates using DNS records for domains managed with Vultr.

---

## Caddyfile Loaders

Ways to load the Caddyfile

---

### docker

This Caddyfile Loader plugin connects to a Docker Swarm cluster and dynamically generates a Caddyfile based on Docker Services metadata.

---

## Server Types

Things Caddy can serve

---

### dns

A DNS server plugin.

### net

TCP/UDP server type plugin to proxy and/or echo traffic.

This plugin serve the purpose to extend Caddy if you would like to handle TCP/UDP traffic. The plugin can be used to proxy traffic to another listener, or simply to echo data back to it's caller.

*The plugin works as intented but is still in BETA*

---

## Event Hooks

Plugins that are triggered by events

---

### hook.service

Always wanted to run Caddy as a service? Here's what you've been waiting for.

This plugin was coded by me and Henrique Dias, who is the main contributor for File Manager.

Notes: Notice that if you install the service with a name that is not the default's, you will need to specify it everytime you use one of the other commands using the flag ***-name***.

---
Reference: https://caddyserver.com/download