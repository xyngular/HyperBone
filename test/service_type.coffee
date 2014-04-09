{
  ServiceType
} = require '../src'


jQuery = require 'jQuery'


sinon = require 'sinon'
{expect} = require 'chai'


describe 'ServiceType', ->
  fakeUrl = '/example/'
  type = new ServiceType

  expect_error = (action, Type) -> ->
    expect action
      .to.throw Type

  describe 'parseModel', ->
    it 'should throw an AbstractionError',
      expect_error type.parseModel,
      Error

  describe '#discoverResources', ->
    it 'should throw an AbstractionError',
      expect_error type.discoverResources,
      Error

  describe '#parseCollection', ->
    it 'should throw an parseCollection',
      expect_error type.parseCollection,
      Error

  describe 'url', ->
    it 'should return the provided url', ->
      expect type.url fakeUrl
        .to.equal fakeUrl

  describe 'request', ->
    it 'should call jQuery.ajax with the provided arguments', sinon.test ->
      ajax = jQuery.ajax
      jQuery.ajax = sinon.stub()

      callingArgs = [
        '/example/'
        {}
      ]

      type.request.apply type, callingArgs

      expect jQuery.ajax.calledOnce
        .to.be.true

      args = jQuery.ajax.firstCall.args
      expect args
        .to.deep.equal callingArgs

      jQuery.ajax = ajax
