module BrInvoicesPdf
  module Nfce
    module Renderer
      module CustomerIdentification
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            add_customer_identification(pdf, data, identificator(data[:customer]))
          end
        end

        def identificator(data)
          identification = data[:identification_type]
          number = data[:identification]

          case identification
          when 'CPF'
            "CONSUMIDOR: #{format_cpf(number)}"
          when 'CNPJ'
            "CONSUMIDOR: #{format_cnpj(number)}"
          else
            'CONSUMIDOR NÃO IDENTIFICADO'
          end
        end
        private_class_method :identificator

        # :reek:FeatureEnvy
        def add_customer_identification(pdf, data, identificator)
          address = data[:customer][:address]
          pdf.text("Consumidor\n\n", style: :italic)
          pdf.text(identificator, align: :center)
          pdf.text(format_address(address), align: :center) if address[:streetname]
        end
        private_class_method :add_customer_identification
      end
    end
  end
end
