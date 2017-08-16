describe BrInvoicesPdf::Cfe::Renderer::PaymentForms do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf') }
    let(:data) { { payments: [{ type: 'SOME', amount: 12 }], payment: { cash_back: 1, payd: 13 } } }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    let(:width) { 100 }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
      allow(pdf).to receive(:move_down)
    end

    context 'correct infos' do
      context 'when cpf is present' do
        let(:payments) do
          [['FORMA DE PAGAMENTO', 'VALOR'],
           ['SOME', '12,00'],
           ['TROCO', '1,00'],
           ['TOTAL', '13,00']]
        end
        it do
          expect(pdf).to receive(:table).with(payments, width: width)
          subject
        end
      end
    end
  end
end
