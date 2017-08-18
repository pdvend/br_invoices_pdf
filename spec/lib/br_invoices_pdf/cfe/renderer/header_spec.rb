describe BrInvoicesPdf::Cfe::Renderer::Header do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { cpf: cpf, document_number: document_number } }
    let(:cpf) { '99999999999' }
    let(:document_number) { '999' }
    let(:formated_cpf) { '999.999.999-99' }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }

    context 'correct infos' do
      before do
        allow(described_class).to receive(:pdf_setup).and_yield
        allow(pdf).to receive(:font)
        allow(pdf).to receive(:move_down)
        expect(pdf).to receive(:text).with("Extrato: #{document_number}", align: :center)
        expect(pdf).to receive(:text).with('CUPOM FISCAL ELETRONICO - SAT', align: :center)
      end

      context 'when cpf is present' do
        it do
          expect(pdf).to receive(:text).with('CONSUMIDOR: ' + formated_cpf, align: :center)
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
