angular.module 'chattyCatty'
  .controller 'RoomController', ($scope, $state, $stateParams, $auth,
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
      if message.author.id isnt UserAuth.getUser().id
        args = [$scope.messages.length, 0].concat message
        Array::splice.apply $scope.messages, args
        $scope.$apply()


    success = (room) ->
      $scope.room = room
      $scope.loading = false
      subscription = FayeClient.subscribe "/rooms/#{room.id}", receiveHandler

    $scope.sendMessage = ->
      message =
        text: $scope.out.text
        author: UserAuth.getUser()
      args = [$scope.messages.length, 0].concat
        text: $scope.out.text
        author: UserAuth.getUser()
      
      Array::splice.apply $scope.messages, args
      FayeClient.publish "/rooms/#{$scope.room.id}", message
      $scope.out.text = ""

    failure = (response) ->
      console.error response
      $state.go 'private.internal_error'

    $scope.$on '$destroy', ->
      FayeClient.unsubscribe "/rooms/#{$scope.room.id}"


    RoomsResource.get $stateParams, success, failure
