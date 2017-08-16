describe BrInvoicesPdf::Cfe::Renderer::CompanyIdentification do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { company_attributes: company_attributes } }
    let(:company_attributes) do
      {
        address: address,
        company_name: company_name,
        trading_name: trading_name,
        cnpj: cnpj,
        ie: ie
      }
    end
    let(:address) do
      {
        public_place: public_place,
        number: number,
        complement: complement,
        city: city,
        neighborhood: neighborhood,
        cep: cep,
        state: state
      }
    end
    let(:cnpj) { '99999999999999' }
    let(:ie) { '9999999' }
    let(:company_name) { 'Some Name' }
    let(:trading_name) { 'Trading Name' }
    let(:public_place) { 'SOME PLACE' }
    let(:number) { '99' }
    let(:complement) { 'C' }
    let(:city) { 'SOME CITY' }
    let(:neighborhood) { 'SOME NEIGHBORHOOD' }
    let(:cep) { '999999-999' }
    let(:state) { 'SS' }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    let(:formated_address) { "#{public_place}, #{number}, #{complement}, #{neighborhood}, #{city}/#{state}" }
    let(:formated_cnpj) { '99.999.999/9999-99' }

    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(10)
    end

    context 'pdf_setup' do
      it do
        expect(pdf).to receive(:bounding_box).with([0, cursor], width: 10).and_yield
        expect(pdf).to receive(:pad).with(10).and_yield
        expect(pdf).to receive(:indent).with(10, 10).and_yield
        expect(pdf).to receive(:stroke_bounds)
        allow(pdf).to receive(:text)
        subject
      end
    end

    context 'company_names' do
      it do
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with(company_name, align: :center)
        expect(pdf).to receive(:text).with(trading_name, align: :center)
        expect(pdf).to receive(:text).with("CNPJ: #{formated_cnpj}", align: :center)
        expect(pdf).to receive(:text).with("Inscrição Estadual: #{ie}", align: :center)
        expect(pdf).to receive(:text).with(formated_address, align: :center)
        subject
      end
    end
  end
end
