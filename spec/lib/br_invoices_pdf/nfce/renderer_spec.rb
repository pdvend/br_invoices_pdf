# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    describe Renderer do
      describe '.parse' do
        subject { described_class.pdf(data, options) }
        let(:data) { double('data') }
        let(:options) { { page_size: 'A1' } }

        context 'create a Prawn document' do
          let(:prawn_params) { options.merge(page_size: [width, described_class::AUTO_HEIGHT_MOCK]) }
          before do
            allow(Renderer::BaseRenderer).to receive(:page_paper_width).and_return(width)
          end
          let(:width) { 100 }

          it do
            expect(Prawn::Document).to receive(:new).with(prawn_params)
            subject
          end
        end

        context 'call renderers' do
          it do
            expect(Renderer::CompanyIdentification).to receive(:execute)
            expect(Renderer::Header).to receive(:execute)
            expect(Renderer::ProductTable).to receive(:execute)
            expect(Renderer::Totals).to receive(:execute)
            expect(Renderer::PaymentForms).to receive(:execute)
            expect(Renderer::TaxesInfo).to receive(:execute)
            expect(Renderer::FiscalMessage).to receive(:execute)
            expect(Renderer::CustomerIdentification).to receive(:execute)
            expect(Renderer::QrCode).to receive(:execute)
            subject
          end
        end
      end
    end
  end
end
