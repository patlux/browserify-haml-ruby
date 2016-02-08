
haml2html      = require( './haml2html' )
jsStrEscape    = require( 'js-string-escape' )
transformTools = require( 'browserify-transform-tools' )

options =
  includeExtensions: [ '.haml' ]

transform = ( content, transformOptions, done ) ->

  haml2html( content, style: 'ugly', ( err, html ) ->

    if err?
      done( err )

    return done( null, "module.exports = '" + jsStrEscape( html ) + "';\n" )
  )

module.exports = transformTools.makeStringTransform(
  'rubyhamlify',
  options,
  transform
)
