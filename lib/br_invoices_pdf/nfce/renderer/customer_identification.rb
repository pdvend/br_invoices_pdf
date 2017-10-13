module BrInvoicesPdf
  module Nfce
    module Renderer
      module CustomerIdentification
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          pdf_setup(pdf) do
            add_customer_identification(pdf, data, identificator(data[:customer]))
          end

          pdf.move_down(5)
        end

        def identificator(data)
          identification = data[:identification_type]

          case identification
          when 'CPF'
            "CONSUMIDOR: #{format_cpf(data[:identification])}"
          when 'CNPJ'
            "CONSUMIDOR: #{format_cnpj(data[:identification])}"
          else
            "CONSUMIDOR NÃO IDENTIFICADO"
          end
        end
        private_class_method :identificator

        def add_customer_identification(pdf, data, identificator)
          pdf.text("Consumidor\n\n", style: :italic)
          pdf.text(identificator, align: :center)
          pdf.text(format_address(data[:customer][:address]), align: :center) if data[:customer][:address]
          pdf.font('Helvetica', style: :normal, align: :center)
        end
        private_class_method :add_customer_identification
      end
    end
  end
end
