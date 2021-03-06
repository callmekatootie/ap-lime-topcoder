'use strict'

landing = ($state, ChallengeService, Helpers, ENV) ->
  vm        = this
  vm.domain = ENV.domain

  # Make sure there are 3 challenges showing.
  # The first challenge should be of type 'PEER'.
  # If not, fill with other challenge types.
  ChallengeService.getChallenges review: 'PEER'
  .then (response) ->
    peerChallenges = response.data.data.slice 0, 1
    numPeerChallenges = peerChallenges.length

    ChallengeService.getChallenges(review: 'COMMUNITY,INTERNAL')
    .then (response) ->
      nonPeerChallenges = response.data.data.slice 0, 3
      if numPeerChallenges == 1
        vm.challenges = peerChallenges.concat(nonPeerChallenges.slice 0, 2)
      else if numPeerChallenges == 0
        vm.challenges = nonPeerChallenges

      Helpers.formatArray vm.challenges
      Helpers.processChallenge challenge for challenge in vm.challenges

  MktoForms2.loadForm '//app-abc.marketo.com', '921-UOU-112', 1944, (form) ->
    form.onSuccess () ->
      $state.go 'confirmNewsletter'
      false

  return vm

angular.module('lime-topcoder').controller 'landing', [
  '$state'
  'ChallengeService'
  'Helpers'
  'ENV'
  landing
]
