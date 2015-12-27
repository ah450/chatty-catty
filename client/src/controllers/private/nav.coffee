angular.module 'chattyCatty'
  .controller 'PrivateNavController', ($scope, $state, UserAuth) ->
    $scope.logout = ->
      UserAuth.logout()
      $state.go 'public.login'
