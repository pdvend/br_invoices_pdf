describe BrInvoicesPdf::Util::XmlLocate do
  let(:xml) { Ox.parse(xml_string) }
  let(:path) { 'middle/bottom' }
  let(:xml_string) { "<top><middle>#{bottom}</middle></top>" }
  let(:bottom) { "<bottom>#{value}</bottom>" }
  let(:value) { 'some_value' }

  describe '.locate_element' do
    subject { described_class.locate_element(xml, 'middle/bottom') }

    context 'when present' do
      it { expect(subject).to eq(value) }
    end

    context 'when nil' do
      let(:bottom) { nil }
      it { expect(subject).to be_nil }
    end
  end

  describe '.node_locate' do
    subject { described_class.node_locate(xml, path) }
    let(:path) { 'bottom' }

    context 'when present' do
      it { expect(subject).to eq(value) }
    end

    context 'when nil' do
      let(:bottom) { nil }
      it { expect(subject).to be_nil }
    end
  end
end
