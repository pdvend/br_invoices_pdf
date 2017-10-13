module BrInvoicesPdf
  module Nfce
    module Renderer
      module TaxesInfo
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            tribute_values(pdf, data[:taxes])
          end
        end

        # :reek:FeatureEnvy
        def tribute_values(pdf, taxes)
          pdf.text("Tributos\n\n", style: :italic)
          value = format_currency(taxes[:amount])
          msg = 'Informação dos tributos totais incidentes (Lei Federal 12.741/2012)'
          text = "#{msg}:\n R$ #{value} (#{taxes[:percent]})\n\n"
          pdf.text(text, align: :center)
        end
        private_class_method :tribute_values
      end
    end
  end
end
