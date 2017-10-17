# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Renderer::PaymentForms do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', table: table) }
    let(:table) { double('table', columns: columns, row: row) }
    let(:row) { double('row', 'font_style=' => 1) }
    let(:columns) { double('column', 'valign=' => 1, 'align=' => 1) }
    let(:data) { { payments: [{ type: type, amount: amount, cashback: nil }], totals: totals } }
    let(:totals) { { total: total } }
    let(:type) { 'SOME' }
    let(:amount) { '12,00' }
    let(:total) { '13,00' }
    let(:width) { 100 }
    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
      allow(pdf).to receive(:move_down)
    end

    context 'correct infos without casback' do
      context 'when cpf is present' do
        let(:payments) do
          [['FORMA DE PAGAMENTO', 'VALOR'],
           [type, amount],
           ['TOTAL', total]]
        end
        it do
          expect(pdf).to receive(:table).with(payments, width: width).and_yield(table)
          subject
        end
      end
    end

    context 'correct infos with casback' do
      let(:data) { { payments: [{ type: type, amount: amount, cashback: cashback }], totals: totals } }
      let(:cashback) { 1 }

      context 'when cpf is present' do
        let(:payments) do
          [['FORMA DE PAGAMENTO', 'VALOR', 'TROCO'],
           [type, amount, cashback],
           ['TOTAL', total, nil]]
        end
        it do
          expect(pdf).to receive(:table).with(payments, width: width).and_yield(table)
          subject
        end
      end
    end
  end
end
