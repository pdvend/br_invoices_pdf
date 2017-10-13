describe BrInvoicesPdf::Cfe::Parser::DocumentNumber do
  describe '.execute' do
    subject { described_class.execute(xml) }

    let(:xml) { Ox.dump(foo: 'bar') }

    before do
      allow_any_instance_of(BrInvoicesPdf::Util::XmlLocate).to receive(:locate_element)
        .with(xml, 'infCFe/ide/nCFe').and_return(document_number)
    end

    let(:document_number) { '999' }

    it { expect(subject).to eq(document_number) }
  end
end
