angular.module 'chattyCatty'
  .factory 'UserAuth', ($auth, $q, configurations) ->
    class UserService
      constructor: ->
        
      @property 'signedIn',
        get: ->
          $auth.isAuthenticated()

      login: (info, expiration) ->
        deferred = $q.defer()
        configurations.then (config) ->
          expiration ||= config.default_token_exp
          data =
            token: info
            expiration: expiration
          $auth.login data
            .then (response) ->
              deferred.resolve response
            .catch (response) ->
              deferred.reject response
        .catch (response) ->
          deferred.reject response
        return deferred.promise

      signup: (user) ->
        data =
          user: user
        $auth.signup data

      logout: ->
        if @signedIn
          $auth.logout()
        
    return new UserService
    