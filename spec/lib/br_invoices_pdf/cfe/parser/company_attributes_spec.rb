describe BrInvoicesPdf::Cfe::Parser::CompanyAttributes do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Cfe::Parser::BaseParser
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock('infCFe/emit/xNome', name)
      locate_element_mock('infCFe/emit/xFant', trading_name)
      locate_element_mock('infCFe/emit/enderEmit/CEP', zipcode)
      locate_element_mock('infCFe/ide/CNPJ', cnpj)
      locate_element_mock('infCFe/emit/IE', ie)
      locate_element_mock('infCFe/emit/IM', im)
      locate_element_mock('infCFe/emit/enderEmit/xLgr', public_place)
      locate_element_mock('infCFe/emit/enderEmit/nro', number)
      locate_element_mock('infCFe/emit/enderEmit/xCpl', complement)
      locate_element_mock('infCFe/emit/enderEmit/xMun', city)
      locate_element_mock('infCFe/emit/enderEmit/xBairro', neighborhood)
      locate_element_mock('infCFe/emit/enderEmit/CEP', zipcode)
      locate_element_mock('infCFe/ide/cUF', state)
    end

    let(:name) { 'Nome' }
    let(:trading_name) { 'Trading Name' }
    let(:zipcode) { '99999-999' }
    let(:cnpj) { '99.999.999/9999-99' }
    let(:ie) { '998989' }
    let(:im) { '8998' }
    let(:public_place) { 'Public Place' }
    let(:number) { '99' }
    let(:complement) { 'Complement' }
    let(:city) { 'Some City' }
    let(:neighborhood) { 'Some Neighborhood' }
    let(:state) { '12' }

    context '' do
      it { expect(subject[:company_name]).to eq(name) }
      it { expect(subject[:trading_name]).to eq(trading_name) }
      it { expect(subject[:zipcode]).to eq(zipcode) }
      it { expect(subject[:cnpj]).to eq(cnpj) }
      it { expect(subject[:ie]).to eq(ie) }
      it { expect(subject[:im]).to eq(im) }
      it { expect(subject[:address][:public_place]).to eq(public_place) }
      it { expect(subject[:address][:number]).to eq(number) }
      it { expect(subject[:address][:complement]).to eq(complement) }
      it { expect(subject[:address][:city]).to eq(city) }
      it { expect(subject[:address][:neighborhood]).to eq(neighborhood) }
      it { expect(subject[:address][:cep]).to eq(zipcode) }
      it { expect(subject[:address][:state]).to eq('AC') }
    end
  end
end
