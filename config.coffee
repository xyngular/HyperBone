exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  paths:
    app: 'src'
    public: 'build'
  files:
    javascripts:
      joinTo:
        'backbone.hyperbone.js': /^src/
        'test/test.js': /^test/
      order:
        before: [
          'src/main.coffee'
        ]
