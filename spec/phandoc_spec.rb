require 'spec_helper'

describe 'Phandoc' do
  let(:html) { '<html><head></head><body><div id="test">foo</div></body></html>' }

  it 'builds dom with html string' do
    doc = Phandoc.new(html)
    expect(doc.html).to eq(html)
  end

  it 'executes javascript code' do
    doc = Phandoc.new(html)
    result = doc.execute <<-SCRIPT
      document.getElementById("test").innerHTML = "bar";
      console.log('baaaaaar!');
    SCRIPT
    expect(result).to eq('baaaaaar!')
    expect(doc.html).to include('<div id="test">bar</div>')
  end
end