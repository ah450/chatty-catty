angular.module 'chattyCatty'
  .factory 'configurations', (endpoints, $http) ->
    $http.get endpoints.configurations.index, {cache: true}