angular.module 'chattyCatty'
  .config ($authProvider, apiHost) ->
    $authProvider.tokenPrefix = 'chattyCatty-sattelizer'
    $authProvider.httpInterceptor = true
    $authProvider.loginOnSignup = true
    $authProvider.storage = 'localStorage'
    $authProvider.baseUrl = apiHost
    $authProvider.signupUrl = 'users.json'
    $authProvider.loginUrl = 'tokens.json'

angular.module 'chattyCatty'
  .run ($rootScope, $state, UserAuth, redirect) ->
    # Authorization checks
    # applies to states that provide authRule method in their data object
    $rootScope.$on '$stateChangeStart', (e, toState, toParams) ->
      return if angular.isUndefined toState.data
      return if !angular.isFunction toState.data.authRule
      authStatus = toState.data.authRule UserAuth
      if !authStatus.allowed
        redirect.push
          state: toState
          params: toParams
        e.preventDefault()
        $state.go authStatus.to, authStatus.params