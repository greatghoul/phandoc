require 'phantomjs'
require 'tempfile'

class Phandoc
  def initialize(html)
    @html = html
  end

  def execute(code)
    result = []
    
    html_file = Tempfile.new('phantom_html')
    js_file   = Tempfile.new('phantom_js')
    script_file = Tempfile.new('phantom_script')

    begin
      html_file.write(@html)
      html_file.flush

      js_file.write(code)
      js_file.flush

      script_file.write <<-JAVASCRIPT
        var fs = require('fs');
        var htmlContent = fs.read('#{html_file.path}');
        var jsContent = fs.read('#{js_file.path}');

        var webpage = require('webpage');
        var page = webpage.create();

        page.content = htmlContent;

        var output = page.evaluate(function(script) {
          return eval(script);
        }, jsContent);

        console.log(output);
        console.log(page.content.replace(/^/mg, '[:PHANDOC_SOURCE:] '));

        phantom.exit();
      JAVASCRIPT
      script_file.flush

      html = []
      Phantomjs.run(script_file.path) do |line|
        if line.start_with?('[:PHANDOC_SOURCE:] ')
          html << line.sub(/(^\[:PHANDOC_SOURCE:\] |\n$)/, '')
        else
          result << line.sub(/\n$/, '')
        end
      end

      @html = html.join("\n")
    ensure
      html_file.close
      html_file.unlink

      js_file.close
      js_file.unlink

      script_file.close
      script_file.unlink
    end

    result.join("\n")
  end

  def html
    @html
  end
end