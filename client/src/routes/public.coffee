angular.module 'chattyCatty'
  .config ($stateProvider) ->

    publicState =
      name: 'public'
      templateUrl: 'public/root.html'
      url: ''
      abstract: true
      data:
        authRule: (userAuth) ->
          if userAuth.signedIn
            {
              to: 'private.rooms'
              params: {}
              allowed: false
            }
          else
            {
              allowed: true
            }


    loginState =
      name: 'public.login'
      url: '/login'
      views:
        'pageContent':
          templateUrl: 'public/login.html'
          controller: 'LoginController'

    signupState =
      name: 'public.signup'
      url: '/signup'
      views:
        'pageContent':
          templateUrl: 'public/signup.html'
          controller: 'SignupController'
    aboutState =
      name: 'public.about'
      url: '/about'
      views:
        'pageContent':
          templateUrl: 'public/about.html'

    internalErrorState =
      name: 'public.internal_error'
      url: '/oops'
      views:
        'pageContent':
          templateUrl: 'public/internal_error.html'

    $stateProvider
      .state publicState
      .state loginState
      .state signupState
      .state aboutState
      .state internalErrorState





