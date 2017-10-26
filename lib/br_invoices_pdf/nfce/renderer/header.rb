# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module Header
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          pdf_setup(pdf) do
            add_header_config(pdf, data)
          end

          pdf.move_down(5)
        end

        def add_header_config(pdf, _data)
          pdf.font('Helvetica', style: :bold)
          msg = 'DANFE NFC-e - Documento Auxiliar de Nota Fiscal Eletrônica para consumidor final'
          pdf.text(msg, align: :center)
          pdf.font('Helvetica', style: :normal, align: :center)
          pdf.text('Não permite aproveiamento de crédito de ICMS', align: :center)
        end
        private_class_method :add_header_config
      end
    end
  end
end
