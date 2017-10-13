describe BrInvoicesPdf::Nfce::Renderer::CompanyIdentification do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { company: company_attributes } }
    let(:company_attributes) do
      {
        name: name,
        cnpj: cnpj,
        state_number: state_number,
        address: address
      }
    end
    let(:address) do
      {
        streetname: street_name,
        number: number,
        city: city,
        district: district,
        state: state
      }
    end
    let(:cnpj) { '99999999999999' }
    let(:state_number) { '9999999' }
    let(:name) { 'Some Name' }
    let(:street_name) { 'SOME PLACE' }
    let(:number) { '99' }
    let(:complement) { 'C' }
    let(:city) { 'SOME CITY' }
    let(:district) { 'SOME NEIGHBORHOOD' }
    let(:state) { 'SS' }
    let(:formated_address) { "#{street_name}, #{number}, #{district}, #{city}/#{state}" }
    let(:formated_cnpj) { '99.999.999/9999-99' }

    context 'company_names' do
      it do
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with(name, align: :center)
        expect(pdf).to receive(:text).with(formated_address, align: :center)
        expect(pdf).to receive(:text).with("CNPJ: #{formated_cnpj}", align: :center)
        expect(pdf).to receive(:text).with("Inscrição Estadual: #{state_number}", align: :center)
        subject
      end
    end
  end
end
