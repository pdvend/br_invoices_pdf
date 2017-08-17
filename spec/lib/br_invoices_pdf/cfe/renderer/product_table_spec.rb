describe BrInvoicesPdf::Cfe::Renderer::ProductTable do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', move_down: nil) }
    let(:data) { { products: [product] } }
    let(:table) { double('table', row: row, columns: column, width: width) }
    let(:row) { double('row') }
    let(:column) { double('column') }
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
    let(:quantity) { BigDecimal(10) }
    let(:unit_label) { 'some' }
    let(:unit_value) { BigDecimal(99) }
    let(:total_value) { BigDecimal(99) }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    let(:width) { 100 }
    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
    end

    let(:product_rows) do
      [['CÓD.', 'DESCRIÇÃO', 'QTD.', 'UND.', 'V.UNIT', 'V.TOT'],
       [unit_value, description, '10,0000', unit_label, '99,00', '99,00']]
    end
    it do
      expect(pdf).to receive(:table).with(product_rows, width: width).and_yield(table)
      expect(row).to receive('font_style=').with(:bold)
      expect(row).to receive('align=').with(:center)
      expect(column).to receive('valign=').with(:center)
      expect(column).to receive('align=').with(:right)
      expect(table).to receive('column').and_return(column).exactly(3).times
      expect(column).to receive('align=').with(:center)
      expect(column).to receive('width=').exactly(3).times
      subject
    end
  end
end
