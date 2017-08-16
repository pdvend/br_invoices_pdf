describe BrInvoicesPdf::Cfe::Renderer::ProductTable do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf') }
    let(:data) { { products: [product] } }
    let(:product) do
      {
        code: code,
        description: description, 
        quantity: quantity,
        unit_label:  unit_label, 
        unit_value:  unit_value,
        total_value:  total_value
      }
    end

    let(:code) { 99 }
    let(:description) { 'Some Description' }
    let(:quantity) { 10 }
    let(:unit_label) { 'some' }
    let(:unit_value) { 99 }
    let(:total_value) { 99 }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    let(:width) { 100 }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
      allow(pdf).to receive(:move_down)
    end

    context 'correct infos' do
      context 'when cpf is present' do
        let(:product_rows) do
          [["CÓD.", "DESCRIÇÃO", "QTD.", "UND.", "V.UNIT", "V.TOT"],
           [unit_value, description, "10,0000", unit_label, "99,00", "99,00"]]
        end
        it do
          expect(pdf).to receive(:table).with(product_rows, width: width)
          subject
        end
      end
    end
  end
end
