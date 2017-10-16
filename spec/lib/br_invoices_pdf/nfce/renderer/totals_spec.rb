describe BrInvoicesPdf::Nfce::Renderer::Totals do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: double('cursor'), move_down: nil, bounding_box: nil) }
    let(:data) { { totals: params } }
    let(:params) do
      {
        total: total_price,
        discounts: discount,
        subtotal: total,
        items: items,
        cashback: cashback
      }
    end
    let(:cashback) { '0,00' }
    let(:items) { '2,00' }
    let(:total_price) { '90,00' }
    let(:discount) { '10,00' }
    let(:total) { '80,00' }
    let(:width) { 100 }
    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }
    before do
      allow_any_instance_of(base_renderer).to receive(:box).and_yield
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
    end

    context 'correct infos' do
      it do
        expect(pdf).to receive(:text).with('Items', style: :italic)
        expect(pdf).to receive(:text).with(items, align: :right)
        expect(pdf).to receive(:text).with('Total bruto', style: :italic)
        expect(pdf).to receive(:text).with(total, align: :right)
        expect(pdf).to receive(:text).with('Desconto', style: :italic)
        expect(pdf).to receive(:text).with(discount, align: :right)
        expect(pdf).to receive(:text).with('Total', style: :italic)
        expect(pdf).to receive(:text).with(total_price, align: :right)
        subject
      end
    end
  end
end
