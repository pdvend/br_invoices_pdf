describe BrInvoicesPdf::Cfe::Parser::Cpf do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Cfe::Parser::BaseParser
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock('infCFe/dest/CPF', cpf)
    end

    let(:cpf) { '99999999999' }

    it { expect(subject).to eq(cpf) }
  end
end
