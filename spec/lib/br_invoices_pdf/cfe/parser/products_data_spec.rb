describe BrInvoicesPdf::Cfe::Parser::ProductsData do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { double('Ox') }
    let(:element) { double('element') }
    let(:code) { '99' }
    let(:description) { 'Some Product' }
    let(:cfop) { '2121' }
    let(:quantity) { '10.0' }
    let(:unit_label) { 'some' }
    let(:total_value) { '990.0' }
    let(:unit_value) { '99.0' }
    let(:item_value) { '990.0' }
    let(:locate_response) { [element] }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Cfe::Parser::BaseParser
      allow_any_instance_of(base_parser_module).to receive(:node_locate)
        .with(element, path).and_return(value)
    end

    before do
      allow(xml).to receive(:locate).and_return(locate_response)

      locate_element_mock('cProd', code)
      locate_element_mock('xProd', description)
      locate_element_mock('CFOP', cfop)
      locate_element_mock('qCom', quantity)
      locate_element_mock('uCom', unit_label)
      locate_element_mock('vProd', total_value)
      locate_element_mock('vUnCom', unit_value)
      locate_element_mock('vItem', item_value)
    end

    context 'correct values' do
      it { expect(subject.first[:code]).to eq(code) }
      it { expect(subject.first[:description]).to eq(description) }
      it { expect(subject.first[:cfop]).to eq(cfop) }
      it { expect(subject.first[:quantity]).to eq(quantity) }
      it { expect(subject.first[:unit_label]).to eq(unit_label) }
      it { expect(subject.first[:total_value]).to eq(total_value) }
      it { expect(subject.first[:unit_value]).to eq(unit_value) }
      it { expect(subject.first[:item_value]).to eq(item_value) }
    end

    context 'when locate return nil' do
      let(:locate_response) { nil }
      it { expect(subject).to be_nil }
    end

    context 'when locate is empty' do
      let(:locate_response) { [] }
      it { expect(subject).to be_empty }
    end
  end
end
