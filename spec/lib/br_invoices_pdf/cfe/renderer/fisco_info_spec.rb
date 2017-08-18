describe BrInvoicesPdf::Cfe::Renderer::FiscoInfo do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { fisco_obs: [fisco_obs] } }
    let(:fisco_obs) do
      {
        field: 'some_field',
        text: 'Some Text'
      }
    end
    let(:formated_fisco_obs) do
      "#{fisco_obs[:field]}: #{fisco_obs[:text]}"
    end
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }

    before do
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(10)
    end

    context 'pdf_setup' do
      it do
        expect(pdf).to receive(:bounding_box).with([0, cursor], width: 10).and_yield
        expect(pdf).to receive(:pad).with(2).and_yield
        expect(pdf).to receive(:indent).with(2, 2).and_yield
        expect(pdf).to receive(:text).with("Observações do fisco\n\n", style: :italic)
        expect(pdf).to receive(:text).with(formated_fisco_obs, align: :center)
        expect(pdf).to receive(:stroke_bounds)
        subject
      end
    end
  end
end
