describe BrInvoicesPdf::Cfe::Parser::AccessKey do
  describe '.execute' do
    let(:xml) { Ox.parse(xml_string) }
    let(:xml_string) { "<top ><Signature>#{signature}</Signature></top>" }
    let(:signature) { "<SignedInfo>#{nodes}</SignedInfo>" }
    let(:nodes) { "<uri URI=\'#{value}\'></uri>" }
    let(:value) { 'some_value' }

    describe '.locate_element' do
      subject { described_class.execute(xml) }

      context 'when present' do
        it { expect(subject).to eq(value) }
      end

      context 'when signature is nil' do
        let(:signature) { nil }
        it { expect(subject).to be_nil }
      end

      context 'when nodes is nil' do
        let(:nodes) { nil }
        it { expect(subject).to be_nil }
      end

      context 'when value is nil' do
        let(:value) { nil }
        it { expect(subject).to eq('') }
      end
    end
  end
end
