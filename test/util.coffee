{naturalModelName, naturalCollectionName} = require '../src/util'

{expect} = require 'chai'


describe 'Utility Function', ->
  potential_inputs = [
    'salad_dressing',
    'salad-dressing'
    'salad dressing',
  ]

  expectMatch = (translator, expectation) -> (item) ->
    expect translator item
      .to.equal expectation


  describe 'naturalModelName', ->
    it 'should translate strings as expected', ->
      expectation = 'SaladDressing'
      potential_inputs.map expectMatch naturalModelName, expectation

  describe 'naturalCollectionName', ->
    it 'should translate strings as expected', ->
      expectation = 'SaladDressingCollection'
      potential_inputs.map expectMatch naturalCollectionName, expectation
