module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    concat: 
      client:
        src: [
          'public/client/**/*.js'
        ]
        dest: 'public/dist/client.js'
      lib:
        src: [
          'public/lib/underscore.js'
          'public/lib/jquery.js'
          'public/lib/backbone.js'
          'public/lib/handlebars.js'
        ]
        dest: 'public/dist/lib.js'

    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/**/*.js']

    nodemon:
      dev:
        script: 'server.js'

    uglify:
      build:
        src: 'public/dist/production.js'
        dest: 'public/dist/production.min.js'

    jshint:
      files: [
        'app/**/*.js'
        'lib/**/*.js'
        'test/**/*.js'
        'public/**/*.js'
      ]
      options:
        force: 'true'
        jshintrc: '.jshintrc'
        ignores: [
          'public/lib/**/*.js'
          'public/dist/**/*.js'
        ]

    cssmin: {}

    watch:
      scripts:
        files: ['public/client/**/*.js', 'public/lib/**/*.js']
        tasks: ['concat', 'uglify']
      css:
        files: 'public/*.css'
        tasks: ['cssmin']

    shell:
      prodServer: {}

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.registerTask 'server-dev', (target) ->
    
    # Running nodejs in a different process and displaying output on the main console
    nodemon = grunt.util.spawn(
      cmd: 'grunt'
      grunt: true
      args: 'nodemon'
    )
    nodemon.stdout.pipe process.stdout
    nodemon.stderr.pipe process.stderr
    grunt.task.run ['watch']

# //////////////////////////////////////////////////
#  Main grunt tasks
# //////////////////////////////////////////////////

  grunt.registerTask 'test', [
    'mochaTest'
  ]

  grunt.registerTask 'build', []

  grunt.registerTask 'upload', (n) ->
    if grunt.option 'prod'
      # add your production server task here
    else
      grunt.task.run ['server-dev']
   
  grunt.registerTask 'deploy', [
    'concat'
    'uglify'
    'jshint'
    'mochaTest'
  ]
