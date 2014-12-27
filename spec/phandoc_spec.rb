require 'spec_helper'

describe 'Phandoc' do
  let(:html) do
    <<-HTML
      <html>
        <head></head>
        <body>
          <div id="test">foo</div>
          <img src="http://getscroll.dev:3000/i/http:%2F%2Fnews.ltn.com.tw%2Fimages%2Fnews%2Flogo.jpg"  />
          <script type="text/javascript">
          document.write('javascript' + ' works.');
          </script>
        </body>
      </html>
    HTML
  end

  it 'builds dom with html string' do
    doc = Phandoc.new(html)
    expect(doc.html).to eq(html)
  end

  it 'executes javascript code' do
    doc = Phandoc.new(html)
    result = doc.execute <<-SCRIPT
      document.getElementById("test").innerHTML = "bar";
      'baaaaaar!';
    SCRIPT

    expect(doc.html).to include('<div id="test">bar</div>')
    expect(result).to eq('baaaaaar!')
    expect(doc.html).to include('javascript works.')
  end

  it 'executes javascript code with settings' do
    doc = Phandoc.new(html)

    code = <<-SCRIPT
      document.getElementById("test").innerHTML = "bar";
      'baaaaaar!';
    SCRIPT

    result = doc.execute(code, {
      'loadImages' => false,
      'javascriptEnabled' => false,
      'userAgent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36',
    })

    expect(doc.script).to include('loadImages = false')
    expect(doc.script).to include('javascriptEnabled = false')
    expect(doc.script).to include("userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36'")
    
    expect(doc.html).not_to include('<div id="test">bar</div>')
    expect(doc.html).not_to include('javascript works.')
    expect(result).not_to eq('baaaaaar!')
  end
end