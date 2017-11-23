# frozen_string_literal: false

describe BrInvoicesPdf::Nfce::Parser::Company do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      allow(xml).to receive(:name).and_return('NFe')

      locate_element_mock("#{described_class.emit_root_path(xml)}/xNome", name)
      locate_element_mock("#{described_class.emit_root_path(xml)}/CNPJ", cnpj)
      locate_element_mock("#{described_class.emit_root_path(xml)}/IE", state_number)
      locate_element_mock("#{described_class.emit_root_path(xml)}/enderEmit/xLgr", streetname)
      locate_element_mock("#{described_class.emit_root_path(xml)}/enderEmit/nro", number)
      locate_element_mock("#{described_class.emit_root_path(xml)}/enderEmit/xBairro", district)
      locate_element_mock("#{described_class.emit_root_path(xml)}/enderEmit/xMun", city)
      locate_element_mock("#{described_class.emit_root_path(xml)}/enderEmit/UF", state)
    end

    let(:name) { 'Nome' }
    let(:cnpj) { '99.999.999/9999-99' }
    let(:state_number) { '998989' }
    let(:zipcode) { '99999-999' }
    let(:streetname) { 'Public Place' }
    let(:number) { '99' }
    let(:district) { 'Some District' }
    let(:city) { 'Some City' }
    let(:state) { 'DF' }

    context 'parser correct values' do
      it { expect(subject[:name]).to eq(name) }
      it { expect(subject[:cnpj]).to eq(cnpj) }
      it { expect(subject[:state_number]).to eq(state_number) }
      it { expect(subject[:address][:streetname]).to eq(streetname) }
      it { expect(subject[:address][:number]).to eq(number) }
      it { expect(subject[:address][:district]).to eq(district) }
      it { expect(subject[:address][:city]).to eq(city) }
      it { expect(subject[:address][:state]).to eq(state) }
    end
  end
end
