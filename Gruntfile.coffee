module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  configuration = grunt.file.readJSON 'package.json'
  fileName = "dist/<%= configuration.name %>-#{ configuration.version #}.js"

  grunt.initConfig
    configuration: configuration

    coffee:
      target:
        dest: "#{fileName}"
        src: 'src/**/*.coffee'

    concat:
      options:
        banner: """/*
                <%= configuration.name %> #{ configuration.version #}
                License: <%= configuration.license %>
                */\n\n"""

      target:
        dest: "#{fileName}"
        src: "#{fileName}"


  grunt.registerTask 'default', [
    'coffee'
    'concat'
  ]

