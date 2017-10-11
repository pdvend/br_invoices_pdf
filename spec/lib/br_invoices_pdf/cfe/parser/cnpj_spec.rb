describe BrInvoicesPdf::Cfe::Parser::Cnpj do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    before do
      base_parser_module = BrInvoicesPdf::Cfe::Parser::BaseParser
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, 'infCFe/dest/CNPJ').and_return(cnpj)
    end

    let(:cnpj) { '48013766000137' }

    it { expect(subject).to eq(cnpj) }
  end
end
