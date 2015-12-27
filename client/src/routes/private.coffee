angular.module 'chattyCatty'
  .config ($stateProvider) ->
    
    privateState =
      name: 'private'
      templateUrl: 'private/root.html'
      url: ''
      abstract: true
      data:
        authRule: (userAuth) ->
          if userAuth.signedIn
            {
              allowed: true
            }
          else
            {
              to: 'public.login'
              params: {}
              allowed: false
            }

    roomsState =
      name: 'private.rooms'
      url: '/lobby'
      resolve:
        $title: ->
          'Lobby'
      views:
        'privateContent':
          templateUrl: 'private/rooms.html'
          controller: 'RoomsController'

    roomState =
      name: 'private.room'
      url: '/rooms/:id'
      views:
        'privateContent':
          templateUrl: 'private/room.html'
          controller: 'RoomController'

    aboutState =
      name: 'private.about'
      url: '/info'
      views:
        'privateContent':
          templateUrl: 'public/about.html'

    internalErrorState =
      name: 'private.internal_error'
      url: '/ooops'
      views:
        'privateContent':
          templateUrl: 'public/internal_error.html'

    $stateProvider
      .state privateState
      .state roomsState
      .state roomState
      .state internalErrorState
      .state aboutState