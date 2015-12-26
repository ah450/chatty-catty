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

    $stateProvider
      .state privateState
      .state roomsState