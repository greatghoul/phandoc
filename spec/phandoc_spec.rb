require 'spec_helper'

describe 'Phandoc' do
  let(:html) do
    <<-HTML
      <html>
        <head></head>
        <body>
          <div id="test">foo</div>
          <img src="http://img.ltn.com.tw/Upload/liveNews/BigPic/600_php0cgUMU.jpg"  />
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
  end

  it 'executes javascript code with settings' do
    doc = Phandoc.new(html)

    code = <<-SCRIPT
      document.getElementById("test").innerHTML = "bar";
      'baaaaaar!';
    SCRIPT

    result = doc.execute(code, {
      'loadImages' => false,
      'userAgent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36',
    })

    expect(doc.script).to include('"loadImages":false')
    expect(doc.script).to include('"userAgent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36"')
    
    expect(doc.html).to include('<div id="test">bar</div>')
    expect(result).to eq('baaaaaar!')
  end
end