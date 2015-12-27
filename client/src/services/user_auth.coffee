angular.module 'chattyCatty'
  .factory 'UserAuth', ($auth, $q, configurations, localStorageService) ->
    class UserService
      constructor: ->
        
      @property 'signedIn',
        get: ->
          $auth.isAuthenticated()

      login: (info, expiration) ->
        deferred = $q.defer()
        configurations.then (config) =>
          expiration ||= config.default_token_exp
          data =
            token: info
            expiration: expiration
          $auth.login data
            .then (response) =>
              @currentUser = response.data.user
              localStorageService.set 'currentUser', @currentUser
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
          .then (response) =>
            @currentUser = response.data
            localStorageService.set 'currentUser', @currentUser
            return response


      logout: ->
        @currentUser = undefined
        localStorageService.remove 'currentUser'
        if @signedIn
          $auth.logout()

      getUser: ->
        if not angulat.isUndefined @currentUser
          return @currentUser
        else
          return localStorageService.get 'currentUser'
        
    return new UserService
    