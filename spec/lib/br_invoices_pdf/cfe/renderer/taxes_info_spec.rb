describe BrInvoicesPdf::Cfe::Renderer::TaxesInfo do
  describe '.execute' do
    subject { described_class.execute(pdf, data) }
    let(:pdf) { double('pdf', cursor: double('cursor')) }
    let(:data) { { payment: { approximate_value_of_taxes: 12 }, sat_params: sat_params } }
    let(:sat_params) do
      {
        sat_number: sat_number,
        emission_date: emission_date,
        emission_hour: emission_hour
      }
    end
    let(:sat_number) { '123' }
    let(:emission_date) { '20121212' }
    let(:emission_hour) { '131313' }
    let(:base_renderer) { BrInvoicesPdf::Cfe::Renderer::BaseRenderer }
    let(:width) { 100 }
    let(:formated_time) { DateTime.parse(emission_date + emission_hour).strftime('%d/%m/%Y %H:%M:%S') }
    let(:taxes_info) { "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ 12,00\n\n" }
    before do
      allow_any_instance_of(base_renderer).to receive(:box).and_yield
      allow_any_instance_of(base_renderer).to receive(:page_content_width).and_return(width)
      allow(pdf).to receive(:font_size).and_yield
      allow(pdf).to receive(:move_down)
      allow(pdf).to receive(:bounding_box)
    end

    context 'correct infos' do
      context 'when cpf is present' do
        it do
          expect(pdf).to receive(:text).with("Tributos\n\n", style: :italic)
          expect(pdf).to receive(:text).with(taxes_info, align: :center)
          expect(pdf).to receive(:text).with("SAT Número #{sat_number}", align: :center)
          expect(pdf).to receive(:text).with(formated_time, align: :center)
          subject
        end
      end
    end
  end
end
