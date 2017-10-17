# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Parser::Customer do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/CNPJ", cnpj)
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/enderDest/xLgr", streetname)
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/enderDest/nro", number)
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/enderDest/xBairro", district)
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/enderDest/xMun", city)
      locate_element_mock("#{described_class::DEST_ROOT_PATH}/enderDest/UF", state)
    end

    let(:cnpj) { '99.999.999/9999-99' }
    let(:zipcode) { '99999-999' }
    let(:streetname) { 'Public Place' }
    let(:number) { '99' }
    let(:district) { 'Some District' }
    let(:city) { 'Some City' }
    let(:state) { 'DF' }

    context 'parser correct values' do
      it { expect(subject[:address][:streetname]).to eq(streetname) }
      it { expect(subject[:address][:number]).to eq(number) }
      it { expect(subject[:address][:district]).to eq(district) }
      it { expect(subject[:address][:city]).to eq(city) }
      it { expect(subject[:address][:state]).to eq(state) }
    end

    context 'when CNPJ' do
      it { expect(subject[:identification_type]).to eq('CNPJ') }
      it { expect(subject[:identification]).to eq(cnpj) }
    end

    context 'when CPF' do
      before do
        locate_element_mock("#{described_class::DEST_ROOT_PATH}/CNPJ", nil)
        locate_element_mock("#{described_class::DEST_ROOT_PATH}/CPF", cpf)
      end
      let(:cpf) { '11111111111' }

      it { expect(subject[:identification_type]).to eq('CPF') }
      it { expect(subject[:identification]).to eq(cpf) }
    end

    context 'when idEstrangeiro' do
      before do
        locate_element_mock("#{described_class::DEST_ROOT_PATH}/CNPJ", nil)
        locate_element_mock("#{described_class::DEST_ROOT_PATH}/CPF", nil)
        locate_element_mock("#{described_class::DEST_ROOT_PATH}/idEstrangeiro", idEstrangeiro)
      end

      let(:idEstrangeiro) { '11111111111' }

      it { expect(subject[:identification_type]).to eq('idEstrangeiro') }
      it { expect(subject[:identification]).to eq(idEstrangeiro) }
    end
  end
end
