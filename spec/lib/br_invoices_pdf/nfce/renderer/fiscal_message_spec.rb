# frozen_string_literal: true

describe BrInvoicesPdf::Nfce::Renderer::FiscalMessage do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: cursor) }
    let(:cursor) { 10 }
    let(:data) { { emission_details: emission_details } }
    let(:emission_details) do
      { serie: serie, number: number, access_key: access_key,
        emission_timestamp: emission_timestamp,
        check_url: check_url }
    end

    let(:serie) { 1 }
    let(:number) { 1 }
    let(:access_key) { '12345678' }
    let(:emission_timestamp) { Time.new(2017, 10, 13) }
    let(:check_url) { 'www.pdvend.com.br' }
    let(:emission_text) { "Emissão: 00:00:00 13/10/2017 - Via Consumidor\n\n" }
    let(:check_text) { "Consulte pela chave de acesso em: #{check_url} \n\n" }

    let(:base_renderer) { BrInvoicesPdf::Nfce::Renderer::BaseRenderer }

    context 'expect texts' do
      it do
        allow_any_instance_of(base_renderer).to receive(:box).and_yield
        allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(100)
        allow(described_class).to receive(:pdf_setup).and_yield
        expect(pdf).to receive(:text).with("Mensagem Fiscal\n\n", style: :italic)
        expect(pdf).to receive(:text).with("Número: #{number} - Série: #{serie}\n\n", align: :center)
        expect(pdf).to receive(:text).with(emission_text, align: :center)
        expect(pdf).to receive(:text).with(check_text, align: :center)
        expect(pdf).to receive(:text).with("CHAVE DE ACESSO:\n1234 5678", align: :center)

        subject
      end
    end
  end
end
