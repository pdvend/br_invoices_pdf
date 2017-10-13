describe BrInvoicesPdf::Cfe::Parser::Sat do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock('infCFe/ide/numeroCaixa', pos_number)
      locate_element_mock('infCFe/ide/nCFe', ncfe_number)
      locate_element_mock('infCFe/ide/cUF', uf)
      locate_element_mock('infCFe/ide/nserieSAT', sat_number)
      locate_element_mock('infCFe/ide/dEmi', emission_date)
      locate_element_mock('infCFe/ide/hEmi', emission_hour)
      locate_element_mock('infCFe/ide/assinaturaQRCODE', document_qr_code_signature)
    end

    let(:pos_number) { '1' }
    let(:ncfe_number) { '123' }
    let(:uf) { '35' }
    let(:sat_number) { '1231231' }
    let(:emission_date) { '12/12/2012' }
    let(:emission_hour) { '13:00:22' }
    let(:document_qr_code_signature) { 'saqw1w212' }

    context 'correct values' do
      it { expect(subject[:pos_number]).to eq(pos_number) }
      it { expect(subject[:ncfe_number]).to eq(ncfe_number) }
      it { expect(subject[:uf]).to eq('São Paulo') }
      it { expect(subject[:sat_number]).to eq(sat_number) }
      it { expect(subject[:emission_date]).to eq(emission_date) }
      it { expect(subject[:emission_hour]).to eq(emission_hour) }
    end
  end
end
