describe BrInvoicesPdf::Generator do
  let(:renderer) { double('renderer') }
  let(:parser) { double('parser') }
  let(:pdf) { double('pdf') }
  let(:parsed_data) { { foo: :bar } }
  let(:pdf_content) { SecureRandom.base64 }

  describe '.generate' do
    subject { described_class.new(renderer, parser).generate(xml, options) }

    let(:xml) { Ox.dump(foo: :bar) }
    let(:options) { {} }

    it 'calls parser.parse with parsed xml' do
      expect(parser).to receive(:parse).with(kind_of(Ox::Element))
      allow(renderer).to receive(:pdf).and_return(pdf)
      allow(pdf).to receive(:render).and_return(pdf_content)
      subject
    end

    it 'calls renderer.render with parsed data' do
      allow(parser).to receive(:parse).and_return(parsed_data)
      expect(renderer).to receive(:pdf).with(parsed_data, kind_of(Hash)).and_return(pdf)
      allow(pdf).to receive(:render).and_return(pdf_content)
      subject
    end

    it 'merges options with default options' do
      allow(parser).to receive(:parse).and_return(parsed_data)
      expect(renderer).to receive(:pdf).with(parsed_data, page_size: 'A4', margin: [40, 75]).and_return(pdf)
      allow(pdf).to receive(:render).and_return(pdf_content)
      subject
    end

    it 'returns pdf.render result' do
      allow(parser).to receive(:parse).and_return(parsed_data)
      allow(renderer).to receive(:pdf).and_return(pdf)
      allow(pdf).to receive(:render).and_return(pdf_content)
      is_expected.to be(pdf_content)
    end
  end
end
