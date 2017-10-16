describe BrInvoicesPdf::Nfce::Renderer::TaxesInfo do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { taxes: { amount: amount, percent: percent } } }
    let(:icms) { 'Não permite aproveiamento de crédito de ICMS' }
    let(:amount) { '20,00' }
    let(:percent) { '7%' }
    let(:msg) { 'Informação dos tributos totais incidentes (Lei Federal 12.741/2012)' }
    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

    context 'expect texts' do
      it do
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(100)
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with("Tributos\n\n", style: :italic)
        expect(pdf).to receive(:text).with("#{msg}:\n R$ #{amount} (#{percent})\n\n", align: :center)

        subject
      end
    end
  end
end
