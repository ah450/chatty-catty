
angular.module 'chattyCatty', ['ngResource', 'ui.router', 'ui.router.title',
  'chattyCattyTemplates', 'satellizer', 'LocalStorageModule', 'ngAnimate',
  'angulartics', 'angulartics.google.analytics', 'infinite-scroll',
  'ngDialog', 'ngEmbed', 'luegg.directives'
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

# Infinite scroll throttling
angular.module 'infinite-scroll'
  .value 'THROTTLE_MILLISECONDS', 250