module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  configuration = grunt.file.readJSON 'package.json'

  inputFileName = 'src/index.coffee'
  outputFileName = "lib/#{ configuration.name }-#{ configuration.version #}.js"

  options =
    configuration: configuration

    coffee:
      compileWithMaps:
        options:
          sourceMap: no

    concat:
      options:
        banner: """/*
                <%= configuration.name %> #{ configuration.version #}
                License: <%= configuration.license %>
                */\n\n"""

      target:
        src: outputFileName
        dest: outputFileName

    uglify:
      target:
        src: outputFileName
        dest: outputFileName.replace /\.js$/, '.min.js'

  options.coffee.compileWithMaps.files = {}
  options.coffee.compileWithMaps.files[outputFileName] = inputFileName

  grunt.initConfig options

  grunt.registerTask 'default', [
    'coffee'
    'concat'
    'uglify'
  ]
