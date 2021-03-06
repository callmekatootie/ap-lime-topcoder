'use strict'

challenges = ($scope, $state, $stateParams, ChallengeService, Helpers, ENV) ->
  vm = this
  vm.domain = ENV.domain
  vm.loading = false

  vm.pageIndex = 1
  vm.pageSize = 10
  vm.hasMore = true
  vm.challenges = []
  vm.slides = []

  vm.isGrid = false

  vm.challengesType = $stateParams.type

  getChallenges = () ->
    # prepares search request
    request =
      pageIndex: vm.pageIndex
      pageSize: vm.pageSize

    # add review filter if required
    if vm.challengesType == 'peer'
      request.review = 'PEER'
      request.event = ENV.LIME_PROGRAM_ID

    if vm.challengesType == 'all'
      request.review = 'COMMUNITY,INTERNAL'

    # set loading flag
    vm.loading = true

    # call API
    ChallengeService.getChallenges(request)
    .then (response) ->
      # set off loading flag
      vm.loading = false

      # formats challenges for technologies, platforms array fields
      Helpers.formatArray response.data.data

      # process challenge for making info handy for the view
      Helpers.processChallenge challenge for challenge in response.data.data

      # filter challenges
      challenges = Helpers.filterChallenges response.data.data

      # append the retrieved challenges into existing collection
      vm.challenges = vm.challenges.concat challenges

      # total challenges applicable for the given filter
      total = challenges.length

      # detects if we need to show load more button
      if vm.challenges.length == total
        vm.hasMore = false
      else
        vm.hasMore = true

      # prepares challenges to be shown in carousel
      if vm.pageIndex == 1
        vm.slides = vm.challenges.slice 0, 3

    .catch (error) ->
      # TODO show error
      vm.loading = false

  loadMore = () ->
    console.log vm.pageIndex
    vm.pageIndex++
    getChallenges()

  activate = () ->
    getChallenges()


  vm.loadMore = loadMore
  activate()

  return vm


angular.module('lime-topcoder').controller 'challenges', [
  '$scope'
  '$state'
  '$stateParams'
  'ChallengeService'
  'Helpers'
  'ENV'
  challenges
]