describe BrInvoicesPdf::Nfce::Renderer::QrCode do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) do
      double('pdf', cursor: cursor, page_size: page_size, page: page,
                    bounding_box: '', box: double)
    end
    let(:cursor) { 10 }
    let(:page_size) { 640 }
    let(:page_width) { 100.999 }
    let(:qr_code_size) { (page_width * 0.65).to_i }
    let(:page) { double(margins: { left: 1, right: 1 }, size_with: 1, size: 'A4') }
    let(:data) { { emission_details: emission_details } }

    let(:emission_details) { { qrcode_url: 'http://url.com.br' } }

    context '.execute' do
      let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

      let(:qr_code) { double(as_png: double(to_blob: 'blop')) }

      before do
        allow_any_instance_of(base_renderer).to receive(:page_paper_width).and_return(page_width)
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        expect(pdf).to receive(:text).with('QR Code', style: :italic)
        expect(pdf).to receive(:image).exactly(1).times
        expect(pdf).to receive(:move_down).exactly(1).times
        expect(RQRCode::QRCode).to receive(:new).with('http://url.com.br').and_return(qr_code)
        expect(qr_code).to receive(:as_png).with(size: qr_code_size, border_modules: 0)
      end

      it 'generate qrcode' do
        subject
      end
    end
  end
end
