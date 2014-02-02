{naturalModelName, naturalCollectionName} = require '../src/util'

{expect} = require 'chai'


describe 'Utility Function', ->
  describe 'naturalModelName', ->
    it 'should translate strings as expected', ->
      expect naturalModelName 'salad_dressing'
        .to.equal 'SaladDressing'

  describe 'naturalCollectionName', ->
    it 'should translate strings as expected', ->
      expect naturalCollectionName 'salad_dressing'
        .to.equal 'SaladDressingCollection'
