exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  files:
    javascripts:
      joinTo:
        'scripts/backbone.hyperbone.js': /^app/
        'test/scripts/test.js': /^test/
      order:
        before: []

    templates:
      joinTo: 'scripts/app.js'
