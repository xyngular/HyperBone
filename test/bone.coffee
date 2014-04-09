{
  Bone
  ServiceType
} = require '../src'


sinon = require 'sinon'
{expect} = require 'chai'


fakeURL = 'https://google.com/?q=hyperbone'


class MockService extends ServiceType
  url: -> fakeURL
  request: (url) -> url
  discoverResources: ->


describe 'Bone', ->
  options =
    serviceType: MockService
    root: '/api/v2/'

  describe '#constructor', ->
    it 'sets #originalOptions to the original provided object', sinon.test ->
      bone = new Bone options

      expect bone.originalOptions
        .to.deep.equal options

    it 'provides the #initialize interface', sinon.test ->
      initialize = Bone::initialize
      Bone::initialize = sinon.spy Bone::initialize

      bone = new Bone options

      expect bone.initialize.calledOnce
        .to.be.true

      expect bone.initialize.firstCall.args[0]
        .to.deep.equal options

      Bone::initialize = initialize

    it 'provides the #createService interface', sinon.test ->
      createService = Bone::createService
      Bone::createService = sinon.spy Bone::createService

      bone = new Bone options

      expect bone.createService.calledOnce
        .to.be.true

      Bone::createService = createService

  describe '#url', ->
    it 'wraps #url using #service#url', sinon.test ->
      bone = new Bone options

      expect bone.url()
        .to.equal fakeURL

  describe '#request', ->
    it 'generates a request using #service#request type', sinon.test ->
      bone = new Bone options

      request = bone.request '/example/'

      expect request
        .to.equal '/example/'

  describe '#discover', ->
    it 'calls #service#request using the root endpoint', sinon.test ->
      request = Bone::request
      Bone::request = @spy request

      bone = new Bone options

      result = bone.discover()
      args = Bone::request.firstCall.args

      expect args[0]
        .to.equal options.root

      expect args[1]
        .to.deep.equal
          success: bone.service.discoverResources

      Bone::request = request
