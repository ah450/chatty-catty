angular.module 'chattyCatty'
  .controller 'RoomsController', ($scope, $resource, $state, endpoints,
    Pagination, ngDialog) ->
    $scope.rooms = []
    ids = []
    $scope.roomClasses = ['btn-red', 'btn-blue', 'btn-green']
    defaultPageSize = 5
    $scope.scrollDisabled = false
    $scope.loading = true
    $scope.newRoomData = {}
    $scope.processingRoom = false
    $scope.roomCreateError = ''

    roomsResourceDefaultParams =
      id: '@id'
    roomsResourceActions =
      query:
        method: 'GET'
        isArray: false
        cache: true

    roomsResource = $resource endpoints.rooms.resourceUrl,
      roomsResourceDefaultParams, roomsResourceActions

    roomsPagination = new Pagination roomsResource, 'rooms', {}, _.identity,
      defaultPageSize

    # Adds rooms to $scope.rooms starting at begin (index)
    addRoomsCallback = (newRooms, begin) ->
      rooms = _.filter newRooms, (room) ->
        room.id not in ids
      Array::push.apply ids, _.pluck rooms, 'id'
      args = [begin, 0].concat rooms
      $scope.rooms.splice.apply $scope.rooms, args
    # Load first page
    roomsPagination.page(1).then (data) ->
      $scope.loading = false
      addRoomsCallback data, $scope.rooms.length

    # Callback for infinite scroll
    $scope.loadMore = ->
      $scope.scrollDisabled = true
      page = if roomsPagination.pageSize < defaultPageSize then \
        roomsPagination.currentPage else roomsPagination.currentPage + 1
      roomsPagination.page page
        .then (rooms) ->
          addRoomsCallback rooms, $scope.rooms.length
          $scope.scrollDisabled = false

    $scope.showAddDialog = ->
      $scope.newRoomDialog = ngDialog.open
        template: 'private/create_room.html'
        scope: $scope

    $scope.submit = ->
      return if $scope.processingRoom
      $scope.processingRoom = true
      room = new roomsResource $scope.newRoomData
      success = (room) ->
        $scope.newRoomDialog.close()
        $scope.processingRoom = false
        # Add new room to begining
        addRoomsCallback [room], 0
      failure = (response) ->
        if response.status is 422
          $scope.roomCreateError = ("#{key.capitalize()} #{value}." for key, value of response.data)
            .join ' '
          $scope.processingRoom = false
        else
          $state.go 'public.internal_error'
      room.$save success, failure



