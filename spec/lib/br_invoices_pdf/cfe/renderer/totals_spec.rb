# frozen_string_literal: true

describe BrInvoicesPdf::Cfe::Renderer::Totals do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: double('cursor'), move_down: nil, bounding_box: nil) }
    let(:data) { { totals: params } }
    let(:params) do
      {
        total_price: total_price,
        discount: discount,
        total: total
      }
    end
    let(:total_price) { '90,00' }
    let(:discount) { '10,00' }
    let(:total) { '80,00' }
    let(:width) { 100 }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    before do
      allow_any_instance_of(base_renderer).to receive(:box).and_yield
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
    end

    context 'correct infos' do
      context 'when cpf is present' do
        it do
          expect(pdf).to receive(:text).with('Total bruto dos itens', style: :italic)
          expect(pdf).to receive(:text).with(total_price, align: :right)
          expect(pdf).to receive(:text).with('Desconto', style: :italic)
          expect(pdf).to receive(:text).with(discount, align: :right)
          expect(pdf).to receive(:text).with('Total', style: :italic)
          expect(pdf).to receive(:text).with(total, align: :right)
          subject
        end
      end
    end
  end
end
