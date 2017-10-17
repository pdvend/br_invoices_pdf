# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Renderer::Header do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { {} }
    let(:danfe) { 'DANFE NFC-e - Documento Auxiliar de Nota Fiscal Eletrônica para consumidor final' }
    let(:icms) { 'Não permite aproveiamento de crédito de ICMS' }

    context 'expect texts' do
      it do
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:font).with('Helvetica', style: :bold)
        expect(pdf).to receive(:text).with(danfe, align: :center)
        expect(pdf).to receive(:font).with('Helvetica', style: :normal, align: :center)
        expect(pdf).to receive(:text).with(icms, align: :center)
        expect(pdf).to receive(:move_down)
        subject
      end
    end
  end
end
