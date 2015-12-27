angular.module 'chattyCatty'
  .factory 'endpoints', (apiHost) ->
    endpoints =
      configurations:
        index: [apiHost, 'configurations.json'].join '/'
      users:
        get: [apiHost, 'users', ':id.json'].join '/'
      rooms:
        resourceUrl: [apiHost, 'rooms', ':id.json'].join '/'