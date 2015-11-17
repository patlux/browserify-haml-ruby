spawn          = require( 'win-spawn' )

haml2html = ( haml, options, callback ) ->

  args = [ 'haml', '-s' ]

  if typeof options == 'function'
    callback = options

  else if Object.keys( options ).length > 0
    if options.style?
      args.push '-t ' + options.style
    if options.format?
      args.push '-f ' + options.format
    if options.doubleQuotes?
      args.push '-q'
    if options.escapeHtml?
      args.push '-e'
    if options.noEscapeAttrs?
      args.push '--no-escape-attrs'
    if options.cdata?
      args.push '--cdata'

  cp   = spawn( args.shift(), args )

  errors = ''
  cp.stderr.setEncoding( 'utf8' )
  cp.stderr.on( 'data', (data) ->
    errors += data.toString()
  )

  html = ''

  cp.on( 'error', ( err ) ->
    errors = err
  )

  cp.stdout.on( 'data', ( data ) ->
    html += data.toString()
  )

  cp.on 'close', ( code ) ->
    if errors?.length > 0
      return callback( errors )

    if code > 0
      return callback( 'Exit with code ' + code )

    return callback( null, html )

  cp.stdin.write( haml )
  cp.stdin.end()


module.exports = haml2html
