assign = require('object-assign')

APIEndpoints = require('../../constants/AppConstants.coffee').APIEndpoints


_configs =
  configs:
    default:
      apiUrl:                  '/api'
      tokenValidationPath:     '/auth/validate_token'
      forceHardRedirect:       false
      parseExpiry: (headers) ->
        # convert from ruby time (seconds) to js time (millis)
        (parseInt(headers['expiry'], 10) * 1000) || null

      then: ->
        return
      authProviderPaths:
        github:    '/auth/github'
        facebook:  '/auth/facebook'
        google:    '/auth/google_oauth2'

class OAuth
  constructor: (opts={})->
    @configs = assign {}, _configs.configs.default, opts
    @initializeListeners()

  getConfig: ->
    @configs

  setConfig: (opt, val)->
    @configs[opt] = val

  initializeListeners: ->
    if window.addEventListener
      window.addEventListener("message", @handlePostMessage, false)

  # convenience method
  destroy: ->
    if window.removeEventListener
      window.removeEventListener("message", @handlePostMessage, false)

  # handle the events broadcast from external auth tabs/popups
  handlePostMessage: (ev) ->
    if ev.data.message == 'deliverCredentials' || ev.data.message == 'authFailure'
      console.log("received auth from popup: " + ev.data)
      @handleResponse(ev.data)

  handleResponse: (data)->
    @getConfig().then(data)

  # open external auth provider in separate window, send requests for
  # credentials until api auth callback page responds.
  authenticate: (provider, opts={}) ->
    @setConfig("then", opts.then)
    @openAuthWindow(provider, opts)


  # open external window to authentication provider
  openAuthWindow: (provider, opts) ->
    authUrl = @buildAuthUrl(provider, opts)

    if @useExternalWindow()
      @requestCredentials(@createPopup(authUrl))
    else
      @visitUrl(authUrl)


  # ping auth window to see if user has completed registration.
  # this method is recursively called until:
  # 1. user completes authentication
  # 2. user fails authentication
  # 3. auth window is closed
  requestCredentials: (authWindow) ->
    # user has closed the external provider's auth window without
    # completing login.
    if authWindow.closed
      @cancel()
      @handleResponse
        errors: ["Login was not received"]
    # still awaiting user input
    else
      authWindow.postMessage("requestCredentials", "*")
      @t = setTimeout((=>@requestCredentials(authWindow)), 500)

  cancel: (reason) ->
    # cancel any pending timers
    if @t?
      clearTimeout(@t)

    return setTimeout((=> @t = null), 0)

  # popups are difficult to test. mock this method in testing.
  createPopup: (url) ->
    window.open(url)

  # testing actual redirects is difficult. stub this for testing
  visitUrl: (url) ->
    window.location.replace(url)


  buildAuthUrl: (provider, opts={}) ->
    authUrl  = @getConfig().apiUrl
    authUrl += @getConfig().authProviderPaths[provider]
    authUrl += '?auth_origin_url=' + encodeURIComponent(window.location.href)

    if opts.params?
      for key, val of opts.params
        authUrl += '&'
        authUrl += encodeURIComponent(key)
        authUrl += '='
        authUrl += encodeURIComponent(val)

    return authUrl


  # ie8 + ie9 cannot use xdomain postMessage
  useExternalWindow: ->
    !@isIE()

# ie <= 11 do not support postMessage
  isIE: ->
    nav = navigator.userAgent.toLowerCase()
    ((nav and nav.indexOf('msie') != -1) || !!navigator.userAgent.match(/Trident.*rv\:11\./))


module.exports = new OAuth
  apiUrl: APIEndpoints.APIRoot
