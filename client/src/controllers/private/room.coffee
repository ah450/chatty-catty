angular.module 'chattyCatty'
  .controller 'RoomController', ($scope, $state, $stateParams,
    RoomsResource, FayeClient, UserAuth) ->
    $scope.loading = true
    $scope.out = {
      text: ""
    }
    $scope.embedOptions =
      link: true
      linkTarget: '_blank'
    $scope.messages = []
    subscription = null

    receiveHandler = (message) ->
      args = [$scope.messages.length, 0].concat message
      Array::splice.apply $scope.messages, args
      $scope.$apply()


    success = (room) ->
      $scope.room = room
      $scope.loading = false
      subscription = FayeClient.subscribe "/#{room.id}", receiveHandler

    $scope.sendMessage = ->
      FayeClient.publish "/#{$scope.room.id}",
        author: UserAuth.getUser()
        text: $scope.out.text
      $scope.out.text = ""



    failure = (response) ->
      console.error response
      $state.go 'public.internal_error'
    RoomsResource.get $stateParams, success, failure
