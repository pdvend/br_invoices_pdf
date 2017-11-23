# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Parser::EmissionDetails do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }
    let(:qr_code_nodes) { double('qrCode', nodes: [qr_code_value]) }
    let(:qr_code_value) { double('qr_code_value', value: qrcode_url) }

    def locate_element_mock(path, value)
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, path).and_return(value)
    end

    before do
      allow(xml).to receive(:name).and_return('protNFe')
      locate_element_mock("#{described_class.emission_root_path(xml)}/tpEmis", type_code)
      locate_element_mock("#{described_class.emission_root_path(xml)}/nNF", number)
      locate_element_mock("#{described_class.emission_root_path(xml)}/serie", serie)
      locate_element_mock("#{described_class.emission_root_path(xml)}/dhEmi", emission_timestamp)
      locate_element_mock('protNFe/infProt/dhRecbto', receival_timestamp)
      locate_element_mock("#{described_class.emission_root_path(xml)}/cUF", uf_code)
      locate_element_mock("#{described_class.emission_root_path(xml)}/tpAmb", env_type)
      locate_element_mock('protNFe/infProt/chNFe', access_key)
      allow(xml).to receive(:locate).with('NFe/infNFeSupl/qrCode').and_return([qr_code_nodes])
      locate_element_mock('protNFe/infProt/nProt', authorization_protocol)
    end

    let(:type_code) { '1' }
    let(:type) { 'Emissão normal' }
    let(:number) { 99 }
    let(:serie) { 9 }
    let(:emission_timestamp) { Time.now.to_s }
    let(:receival_timestamp) { Time.now.to_s }
    let(:uf_code) { '53' }
    let(:env_type) { '2' }
    let(:access_key) { 'ACCESSKEY' }
    let(:qrcode_url) { 'QRCODE' }
    let(:authorization_protocol) { 'AUTHORIZATIONPROT' }

    context 'parser correct values' do
      it { expect(subject[:type]).to eq(type) }
      it { expect(subject[:number]).to eq(number) }
      it { expect(subject[:serie]).to eq(serie) }
      it { expect(subject[:emission_timestamp]).to eq(Time.parse(emission_timestamp).utc) }
      it { expect(subject[:receival_timestamp]).to eq(Time.parse(receival_timestamp).utc) }
      it { expect(subject[:check_url]).to eq('http://dec.fazenda.df.gov.br/NFCE/') }
      it { expect(subject[:access_key]).to eq(access_key) }
      it { expect(subject[:qrcode_url]).to eq(qrcode_url) }
      it { expect(subject[:authorization_protocol]).to eq(authorization_protocol) }
    end
  end
end
