describe BrInvoicesPdf::Cfe::Renderer::QrCode do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor, page_size: page_size) }
    let(:cursor) { 10 }
    let(:page_size) { 640 }

    let(:data) { {} }

    context '.execute' do
      it 'return qrcode' do
        subject
      end
    end
  end
end
