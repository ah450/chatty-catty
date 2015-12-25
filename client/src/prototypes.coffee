# Prototype extensions for built in objects
angular.module 'chattyCatty'
  .config ->
    if typeof Array::remove isnt 'function'
      Array::remove = (element) ->
        index = @indexOf element
        if index > -1
          @splice index, 1
          return true
        else
          return false

angular.module 'chattyCatty'
  .config ->
    String::capitalize = ->
      return @charAt(0).toUpperCase() + @slice(1).toLowerCase()

angular.module 'chattyCatty'
  .config ->
    Function::property = (prop, desc) ->
      Object.defineProperty @::, prop, desc