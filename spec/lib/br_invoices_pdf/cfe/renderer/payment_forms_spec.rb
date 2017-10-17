# frozen_string_literal: true

describe BrInvoicesPdf::Cfe::Renderer::PaymentForms do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', table: table) }
    let(:table) { double('table', columns: columns, row: row) }
    let(:row) { double('row', 'font_style=' => 1) }
    let(:columns) { double('column', 'valign=' => 1, 'align=' => 1) }
    let(:data) { { payments: [{ type: type, amount: amount }], payment: payment } }
    let(:payment) { { cashback: cashback, paid: paid } }
    let(:type) { 'SOME' }
    let(:amount) { '12,00' }
    let(:cashback) { '1,00' }
    let(:paid) { '13,00' }
    let(:width) { 100 }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
      allow(pdf).to receive(:move_down)
    end

    context 'correct infos' do
      context 'when cpf is present' do
        let(:payments) do
          [['FORMA DE PAGAMENTO', 'VALOR'],
           [type, amount],
           ['TROCO', cashback],
           ['TOTAL', paid]]
        end
        it do
          expect(pdf).to receive(:table).with(payments, width: width).and_yield(table)
          subject
        end
      end
    end
  end
end
