# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Parser::Taxes do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock("#{BrInvoicesPdf::Util::XmlLocate::ROOT_PATH}/total/ICMSTot/vNF", total)
    end

    let(:total) { '100.00' }
    let(:taxes_amount) { '19.00' }
    let(:taxes_percent) { BigDecimal.new('19.00') }

    context 'parser correct values' do
      it { expect(subject[:amount]).to eq(taxes_amount) }
      it { expect(subject[:percent]).to eq(taxes_percent) }
    end
  end
end
