angular.module 'chattyCatty'
  .controller 'SignupController', ($scope, $state, UserAuth) ->
    $scope.processing = false
    $scope.userData = {}
    $scope.submit = ->
      return if $scope.processing
      $scope.processing = true
      UserAuth.signup $scope.userData
        .then ->
          UserAuth.login
            email: $scope.userData.email
            password: $scope.userData.password
          .then ->
            $state.go 'private.rooms'
        .catch (response) ->
          if response.status is 422
            $scope.processing = false
            $scope.error = ("#{key.capitalize()} #{value}." for key, value of response.data)
              .join ' '
          else
            $state.go 'public.internal_error'
