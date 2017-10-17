describe BrInvoicesPdf::Nfce::Renderer::TaxesInfo do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { additional_info: "Texto das Taxas" } }
    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

    context 'expect texts' do
      it do
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(100)
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with("Tributos\n\n", style: :italic)
        expect(pdf).to receive(:text).with("Texto das Taxas\n\n", align: :center)

        subject
      end
    end
  end
end
