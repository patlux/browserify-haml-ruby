fs = require( 'fs' )

browserify  = require( 'browserify' )
coffeeify   = require( 'coffeeify' )
rubyhamlify = require( '../lib' )

# source       = require( 'vinyl-source-stream' )
# transformify = require( 'transformify' )
# expect       = require( 'chai').expect
# path         = require( 'path' )
# exec         = require( 'child_process').exec

cwd = process.cwd( )

describe( 'browserify-haml-ruby', () ->

  it 'should compile haml to html', ( done ) ->

    browserify(
      entries: [ './test/fixtures/app.coffee' ]
      transform: [ coffeeify, rubyhamlify ]
    )
    .bundle( ( err, bundle ) ->
      if err?
        done( err )
      else
        done()
    )

)
