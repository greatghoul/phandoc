require 'spec_helper'

describe 'Phandoc' do
  let(:html) do
    <<-HTML
      <html>
        <head></head>
        <body>
          <div id="test">foo</div>
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
end