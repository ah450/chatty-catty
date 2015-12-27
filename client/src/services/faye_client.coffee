angular.module 'chattyCatty'
  .factory 'FayeClient', () ->
    return new Faye.Client '/faye'