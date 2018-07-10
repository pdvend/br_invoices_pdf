# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module TaxesInfo
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            tribute_values(pdf, data[:additional_info])
          end
        end

        # :reek:FeatureEnvy
        def tribute_values(pdf, taxes)
          pdf.text("Tributos\n\n", style: :italic)
          value = format_currency(taxes)
          text = "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ #{value}\n\n"
          pdf.text(text, align: :center)
        end
        private_class_method :tribute_values
      end
    end
  end
end
