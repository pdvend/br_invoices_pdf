describe BrInvoicesPdf::Cfe::Parser::FiscoObs do
  describe '.execute' do
    let(:xml) { Ox.parse(xml_string) }
    let(:xml_string) { "<top ><infCFe>#{inf_adic}</infCFe></top>" }
    let(:inf_adic) { "<infAdic>#{obs_fisco}</infAdic>" }
    let(:obs_fisco) { "<obsFisco xCampo=\'#{field}\'>#{nodes}</obsFisco>" }
    let(:nodes) { "<text>#{text}</text>" }
    let(:text) { 'some_value' }
    let(:field) { 'some_field' }

    describe '.locate_element' do
      subject { described_class.execute(xml) }

      context 'when present' do
        it { expect(subject.first[:text]).to eq(text) }
        it { expect(subject.first[:field]).to eq(field) }
      end

      context 'when inf_adic is nil' do
        let(:inf_adic) { nil }
        it { expect(subject).to be_empty }
      end

      context 'when obsFisco is nil' do
        let(:obs_fisco) { nil }
        it { expect(subject).to be_empty }
      end

      context 'when nodes is nil' do
        let(:nodes) { nil }
        it { expect(subject.first).to be_nil }
      end

      context 'when attibutes is nor present' do
        let(:obs_fisco) { "<obsFisco>#{nodes}</obsFisco>" }
        it { expect(subject.first).to be_nil }
      end
    end
  end
end
