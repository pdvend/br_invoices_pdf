# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Parser::Totals do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      allow(BrInvoicesPdf::Nfce::Parser::Products).to receive(:execute).and_return(items)
      locate_element_mock("#{described_class::TOTAL_ROOT_PATH}/vProd", subtotal)
      locate_element_mock("#{described_class::TOTAL_ROOT_PATH}/vDesc", discounts)
      locate_element_mock("#{described_class::TOTAL_ROOT_PATH}/vNF", total)
    end

    let(:items) { %w[item_1 Item_2] }
    let(:subtotal) { '99.99' }
    let(:discounts) { '0.00' }
    let(:total) { '99.99' }

    context 'parser correct values' do
      it { expect(subject[:items]).to eq(items.count) }
      it { expect(subject[:subtotal]).to eq(subtotal) }
      it { expect(subject[:discounts]).to eq(discounts) }
      it { expect(subject[:total]).to eq(total) }
    end
  end
end
