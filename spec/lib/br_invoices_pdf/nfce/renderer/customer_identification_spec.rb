describe BrInvoicesPdf::Nfce::Renderer::CustomerIdentification do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { customer: customer } }
    let(:customer) { { identification_type: identification_type, identification: identification,
                     address: address } }

    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

    context 'expect texts' do
      before do
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(100)
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with("Consumidor\n\n", style: :italic)
        expect(pdf).to receive(:move_down).with(5)
      end

      let(:address) { {} }


      context 'when cpf' do
        let(:identification_type) { 'CPF' }
        let(:identification) { '11111111111' }

        it do
          expect(pdf).to receive(:text).with("CONSUMIDOR: 111.111.111-11", align: :center)
          subject
        end
      end

      context 'when cnpj' do
        let(:identification_type) { 'CNPJ' }
        let(:identification) { '11185063000187' }

        it do
          expect(pdf).to receive(:text).with("CONSUMIDOR: 11.185.063/0001-87", align: :center)
          subject
        end
      end

      context 'when cnpj' do
        let(:identification_type) { nil }
        let(:identification) { nil }

        it do
          expect(pdf).to receive(:text).with("CONSUMIDOR NÃO IDENTIFICADO", align: :center)
          subject
        end
      end

      context 'with address' do
        let(:identification_type) { nil }
        let(:identification) { nil }
        let(:address) { { streetname: 'Bel air', number: '412', district: 'Til Phiu',
                        city: 'Los Angeles', state: 'CA' } }

        it do
          expect(pdf).to receive(:text).with("CONSUMIDOR NÃO IDENTIFICADO", align: :center)
          expect(pdf).to receive(:text).with("Bel air, 412, Til Phiu, Los Angeles/CA", align: :center)
          subject
        end
      end
    end
  end
end
