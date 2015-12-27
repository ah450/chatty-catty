angular.module 'chattyCatty'
  .controller 'LoginController', ($scope, $state, UserAuth, redirect) ->
    $scope.userData =
      remember: false
    $scope.processing = false
    $scope.submit = ->
      return if $scope.processing
      $scope.processing = true
      if $scope.userData.remember
        $scope.userData.expiration = 48
      UserAuth.login $scope.userData, $scope.expiration
        .then ->
          if redirect.empty
            $state.go 'private.rooms'
          else
            dest = redirect.pop()
            $state.go dest.state, dest.params
        .catch (response) ->
          if response.status is 401
            $scope.processing = false
            $scope.error = "Invalid email or password"
          else
            $state.go 'public.internal_error'
