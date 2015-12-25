angular.module 'chattyCatty'
  .config ($stateProvider) ->

    publicState =
      name: 'public'
      templateUrl: 'public/root.html'
      url: ''
      abstract: true

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
      views:
        'pageContent':
          templateUrl: 'public/about.html'

    $stateProvider
      .state publicState
      .state loginState
      .state signupState
      .state aboutState





