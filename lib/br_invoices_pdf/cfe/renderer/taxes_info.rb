module BrInvoicesPdf
  module Cfe
    module Renderer
      module TaxesInfo
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            tribute_values(pdf, data[:payment])
            sat_params = data[:sat_params]
            sat_number(pdf, sat_params[:sat_number])
            date_values(pdf, sat_params)
          end
        end

        def date_values(pdf, data)
          time = data[:emission_date] + data[:emission_hour]
          pdf.text(DateTime.parse(time).strftime('%d/%m/%Y %H:%M:%S'), align: :center)
        end
        private_class_method :date_values

        # :reek:FeatureEnvy
        def tribute_values(pdf, payment)
          pdf.text("Tributos\n\n", style: :italic)
          value = format_currency(payment[:approximate_value_of_taxes])
          text = "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ #{value}\n\n"
          pdf.text(text, align: :center)
        end
        private_class_method :tribute_values

        def sat_number(pdf, sat_number)
          pdf.text('SAT Número ' + sat_number, align: :center, style: :bold)
        end
        private_class_method :sat_number
      end
    end
  end
end
