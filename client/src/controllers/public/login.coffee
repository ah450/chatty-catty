angular.module 'chattyCatty'
  .controller 'LoginController', ($scope) ->
    $scope.userData = {}
    $scope.submit = ->
      