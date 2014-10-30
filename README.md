phandoc
=======

Javascript + DOM in your ruby,  based on PhantomJS

## Installation

Add to your Gemfile

    gem 'phandoc'

Or install from command line

    gem install phandoc

## Examples

    require 'phandoc'

    doc = Phandoc.new <<-HTML
      <html>
        <head></head>
        <body>
          <div id="test">foo</div>
        </body>
      </html>
    HTML

    result = doc.execute <<-SCRIPT
      document.getElementById("test").innerHTML = "bar";
      'baaaaaar!';
    SCRIPT

    puts doc.html # output: ... <div id="test">bar</div> ...
    puts result   # output: baaaaaar!

## License

MIT License, please read [LICENSE][] file
