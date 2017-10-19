# frozen_string_literal: true

describe BrInvoicesPdf::Cfe::Renderer::BaseRenderer do
  describe '.format_address' do
    subject { described_class.format_address(address) }
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
    let(:public_place) { 'SOME PLACE' }
    let(:number) { '99' }
    let(:complement) { 'C' }
    let(:city) { 'SOME CITY' }
    let(:neighborhood) { 'SOME NEIGHBORHOOD' }
    let(:cep) { '999999-999' }
    let(:state) { 'SS' }
    let(:expectation) { "#{public_place}, #{number}, #{complement}, #{neighborhood}, #{city}/#{state}" }

    it { expect(subject).to eq(expectation) }
  end
end
