'use strict'

routes = ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) ->

  $locationProvider.html5Mode true

  states =
    landing:
      url         : '/'
      templateUrl : 'landing/landing.html'
      controller  : 'landing as vm'
    learn:
      url         : '/learn'
      templateUrl : 'learn/learn.html'
      controller  : 'learn as vm'
    login:
      url         : '/login?retUrl&retState'
      templateUrl : 'login/login.html'
      controller  : 'login as vm'
    register:
      url         : '/register?utm_campaign&utm_medium&utm_source'
      templateUrl : 'register/register.html'
      controller  : 'register as vm'
    confirmRegistration:
      url         : '/register/confirm'
      templateUrl : 'register/confirm.html'
      controller  : 'register'
    confirmNewsletter:
      url         : '/confirmation'
      templateUrl : 'confirmNewsletter/confirmNewsletter.html'
    challenges:
      url         : '/challenges/type/:type'
      templateUrl : 'challenges/challenges.html'
      controller  : 'challenges as vm'

  for name, state of states
    $stateProvider.state name, state

  $urlRouterProvider.otherwise '/'

  $httpProvider.interceptors.push 'HeaderInterceptor'

angular.module('lime-topcoder').config [
  '$stateProvider'
  '$urlRouterProvider'
  '$httpProvider'
  '$locationProvider'
  routes
]
