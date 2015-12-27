angular.module 'chattyCatty'
  .factory 'RoomsResource', ($resource, endpoints) ->
    roomsResourceDefaultParams =
      id: '@id'
    roomsResourceActions =
      query:
        method: 'GET'
        isArray: false
        cache: true

    $resource endpoints.rooms.resourceUrl,
          roomsResourceDefaultParams, roomsResourceActions