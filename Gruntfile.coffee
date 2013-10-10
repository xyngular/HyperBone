module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  configuration = grunt.file.readJSON 'package.json'
  fileName = "dist/<%= configuration.name %>-#{ configuration.version #}.js"

  grunt.initConfig
    configuration: configuration

    coffee:
      target:
        src: 'src/**/*.coffee'
        dest: fileName

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

  grunt.registerTask 'default', [
    'coffee'
    'concat'
    'uglify'
  ]

