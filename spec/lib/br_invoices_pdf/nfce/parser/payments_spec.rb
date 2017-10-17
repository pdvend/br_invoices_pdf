# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Parser::Payments do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { double('Ox') }
    let(:node_payments) { double('nodes') }
    let(:type) { '03' }
    let(:amount) { 99.9 }
    let(:cashback) { 1.00 }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(node_payments, path).and_return(value)
    end

    before do
      allow(xml).to receive(:locate).and_return([node_payments])
      locate_element_mock('tPag', type)
      locate_element_mock('vPag', amount)
      locate_element_mock('vTroco', cashback)
    end

    context 'correct values' do
      it { expect(subject.first[:type]).to eq('Cartão de Crédito') }
      it { expect(subject.first[:amount]).to eq(amount) }
      it { expect(subject.first[:cashback]).to eq(cashback) }
    end

    context 'when node_payments is empty' do
      before do
        allow(xml).to receive(:locate).and_return([])
      end
      it { expect(subject).to be_empty }
    end
  end
end
