# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Renderer::BaseRenderer do
  describe '.format_address' do
    subject { described_class.format_address(address) }
    let(:address) do
      {
        streetname: streetname,
        number: number,
        city: city,
        district: district,
        cep: cep,
        state: state
      }
    end
    let(:streetname) { 'SOME PLACE' }
    let(:number) { '99' }
    let(:city) { 'SOME CITY' }
    let(:district) { 'SOME NEIGHBORHOOD' }
    let(:cep) { '999999-999' }
    let(:state) { 'SS' }
    let(:expectation) { "#{streetname}, #{number}, #{district}, #{city}/#{state}" }

    it { expect(subject).to eq(expectation) }
  end
end
