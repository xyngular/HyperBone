module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  configuration = grunt.file.readJSON 'package.json'
  fileName = "dist/#{ configuration.name }-#{ configuration.version #}.js"

  options =
    configuration: configuration

    browserify:
      dist:
        files: {}

        options: transform: ['coffeeify']

    concat:
      options:
        banner: """/*
                <%= configuration.name %> #{ configuration.version #}
                License: <%= configuration.license %>
                */\n\n"""

      target:
        src: fileName
        dest: fileName

    uglify:
      target:
        src: fileName
        dest: fileName.replace /\.js$/, '.min.js'

  options.browserify.dist.files[fileName] = 'src/main.coffee'

  grunt.initConfig options

  grunt.registerTask 'default', [
    'browserify'
    'concat'
    'uglify'
  ]
