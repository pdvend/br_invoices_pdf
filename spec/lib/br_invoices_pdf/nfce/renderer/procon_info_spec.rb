# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Renderer::ProconInfo do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { additional_variables: { procon_message: 'Procon' } } }
    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

    context 'expect texts' do
      let(:text) { "Procon\n\n" }

      it do
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(100)
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with("Mensagem de Interesse do Contribuente:\n\n", style: :italic)
        expect(pdf).to receive(:text).with(text, align: :center)

        subject
      end
    end
  end
end
