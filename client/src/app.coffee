
angular.module 'chattyCatty', ['ngResource', 'ui.router', 'ui.router.title',
  'chattyCattyTemplates', 'satellizer', 'LocalStorageModule', 'ngAnimate',
  'angulartics', 'angulartics.google.analytics'
  ]
  


# Configuration blocks.

angular.module 'chattyCatty'
  .config ($compileProvider) ->
    $compileProvider.debugInfoEnabled true

angular.module 'chattyCatty'
  .config (localStorageServiceProvider) ->
    localStorageServiceProvider.setPrefix('chattyCatty')

angular.module 'chattyCatty'
  .config ($urlMatcherFactoryProvider) ->
    $urlMatcherFactoryProvider.strictMode false

# Defines constants for use within our app.
angular.module 'chattyCatty'
  .constant 'apiHost', '/api'
  .constant 'baseHost', '/'
