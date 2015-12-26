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
          $auth.login _.extend info, {expiration: expiration}
            .then (response) ->
              deferred.resolve response
            .catch (response) ->
              deferred.reject response
        .catch (response) ->
          deferred.reject response
        return deferred.promise

      logout: ->
        if @signedIn
          $auth.logout()
        
    return new UserService
    