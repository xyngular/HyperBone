# TODO: Don't inject these into global scope. Support NodeJS as a first class
# citizen, instead. This is just a stopgap until we have NodeJS support.

global.Backbone ?= require 'backbone'
global._ ?= require 'lodash'

global.jQuery ?= require 'jquery'
global.$ ?= global.jQuery

require 'backbone-relational'
