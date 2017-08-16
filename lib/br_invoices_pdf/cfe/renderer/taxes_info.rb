module BrInvoicesPdf
  module Cfe
    module Renderer
      module TaxesInfo
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text("Tributos\n\n", style: :italic)

            tribute_values(pdf, data)
            date_values(pdf, data)
          end
        end

        def date_values(pdf, data)
          time = data[:sat_params][:emission_date] + data[:sat_params][:emission_hour]
          pdf.text(DateTime.parse(time).strftime('%d/%m/%Y %H:%M:%S'), align: :center)
        end
        private_class_method :date_values

        def tribute_values(pdf, data)
          value = format_currency(BigDecimal(data[:payment][:approximate_value_of_taxex]))
          text = "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ #{value}\n\n"
          pdf.text(text, align: :center)
          pdf.text('SAT Número ' + data[:sat_params][:sat_number], align: :center)
        end
        private_class_method :tribute_values
      end
    end
  end
end
