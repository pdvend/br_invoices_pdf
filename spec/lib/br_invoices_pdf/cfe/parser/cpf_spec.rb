# frozen_string_literal: true

describe BrInvoicesPdf::Cfe::Parser::Cpf do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    before do
      base_parser_module = BrInvoicesPdf::Util::XmlLocate
      allow_any_instance_of(base_parser_module).to receive(:locate_element)
        .with(xml, 'infCFe/dest/CPF').and_return(cpf)
    end

    let(:cpf) { '99999999999' }

    it { expect(subject).to eq(cpf) }
  end
end
