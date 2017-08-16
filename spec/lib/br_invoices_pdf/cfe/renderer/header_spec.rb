describe BrInvoicesPdf::Cfe::Renderer::Header do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { cpf: '99999999999', document_number: '999' } }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(10)
    end

    context 'correct infos' do
      before do
        allow_any_instance_of(base_renderer).to receive(:pdf_setup).and_yield
        allow(pdf).to receive(:font)
        allow(pdf).to receive(:move_down)
        expect(pdf).to receive(:text).with("Extrato: #{data[:document_number]}", align: :center)
        expect(pdf).to receive(:text).with('CUPOM FISCAL ELETRONICO - SAT', align: :center)
      end

      context 'when cpf is present' do
        it do
          expect(pdf).to receive(:text).with('CONSUMIDOR:' + data[:cpf], align: :center)

          subject
        end
      end

      context 'when cpf not is present' do
        let(:data) { { document_number: '999' } }

        it do
          expect(pdf).to receive(:text).with('CONSUMIDOR NAO IDENTIFICADO', align: :center)

          subject
        end
      end
    end
  end
end
