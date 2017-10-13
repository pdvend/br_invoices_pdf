describe BrInvoicesPdf::Cfe::Parser::Payments do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { double('Ox') }
    let(:node_payments) { double('nodes') }
    let(:element) { double('element') }
    let(:element_value) { 'MP' }
    let(:type) { '03' }
    let(:amount) { 99.9 }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(element, path).and_return(value)
    end

    before do
      allow(xml).to receive(:locate).and_return([node_payments])
      allow(node_payments).to receive(:nodes).and_return([element])
      allow(element).to receive(:value).and_return(element_value)
      locate_element_mock('cMP', type)
      locate_element_mock('vMP', amount)
    end

    context 'correct values' do
      it { expect(subject.first[:type]).to eq('Cartão de Crédito') }
      it { expect(subject.first[:amount]).to eq(amount) }
    end

    context 'when element_value is nil' do
      let(:element_value) { nil }
      it { expect(subject).to be_empty }
    end

    context 'when node_payments is nil' do
      before do
        allow(xml).to receive(:locate).and_return(nil)
      end
      it { expect(subject).to be_nil }
    end

    context 'when node_payments is nil' do
      before do
        allow(xml).to receive(:locate).and_return([])
      end
      it { expect(subject).to be_nil }
    end
  end
end
