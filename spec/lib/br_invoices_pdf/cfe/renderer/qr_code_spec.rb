describe BrInvoicesPdf::Cfe::Renderer::QrCode do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor, page: page) }
    let(:cursor) { 10 }
    let(:page) { double('page', size: page_size, margins: { left: 10, right: 10 }) } 
    let(:page_size) { 'A1' }
    let(:data) { {} }
    let(:bar_code_one) { double('bar_code') } 

    before do
      allow(Barby::PngOutputter).to receive(:new).and_return(bar_code_one)
      allow(Barby::Code39).to receive(:new).and_return(bar_code_one)
      allow(bar_code_one).to receive(:to_png).and_return(bar_code_one)
      allow(StringIO).to receive(:new).with(bar_code_one).and_return(bar_code_one)

      allow(pdf).to receive(:bounding_box)
    end

    context '.execute' do
      it 'return qrcode' do
        expect(pdf).to receive(:image)
        subject
      end
    end
  end
end
