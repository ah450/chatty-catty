angular.module 'chattyCatty'
  .factory 'endpoints', (apiHost) ->
    endpoints =
      configurations:
        index: [apiHost, 'configurations.json'].join '/'