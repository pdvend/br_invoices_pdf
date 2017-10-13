describe BrInvoicesPdf::Cfe::Parser::Payment do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { double('Ox') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock('infCFe/total/vCFeLei12741', approximate_value_of_taxex)
      locate_element_mock('infCFe/total/vCFe', total)
      locate_element_mock('infCFe/total/ICMSTot/vDesc', discount)
      locate_element_mock('infCFe/total/ICMSTot/vProd', total_price)
      locate_element_mock('infCFe/pgto/vTroco', cash_back)
      locate_element_mock('infCFe/pgto/MP/vMP', paid)
    end

    let(:approximate_value_of_taxex) { 0.9 }
    let(:total) { 99.00 }
    let(:discount) { 9.0 }
    let(:total_price) { 90.0 }
    let(:cash_back) { 10.0 }
    let(:paid) { 100.0 }

    context 'correct values' do
      it { expect(subject[:approximate_value_of_taxes]).to eq(approximate_value_of_taxex) }
      it { expect(subject[:total]).to eq(total) }
      it { expect(subject[:discount]).to eq(discount) }
      it { expect(subject[:total_price]).to eq(total_price) }
      it { expect(subject[:cashback]).to eq(cash_back) }
      it { expect(subject[:paid]).to eq(paid) }
    end
  end
end
