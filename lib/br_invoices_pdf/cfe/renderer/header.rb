module BrInvoicesPdf
  module Cfe
    module Renderer
      module Header
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          pdf_setup(pdf) do
            add_header_config(pdf, data, identificator(data))
          end

          pdf.move_down(5)
        end

        def identificator(data)
          return 'CONSUMIDOR NAO IDENTIFICADO' if data[:cpf].nil? && data[:cnpj].nil?
          value = data[:cpf].nil? ? format_cnpj(data[:cnpj]) : format_cpf(data[:cpf])
          'CONSUMIDOR: ' + value
        end
        private_class_method :identificator

        def add_header_config(pdf, data, identificator)
          pdf.font('Helvetica', style: :bold)
          pdf.text("Extrato: #{data[:document_number]}", align: :center)
          pdf.text(identificator, align: :center)
          pdf.text('CUPOM FISCAL ELETRONICO - SAT', align: :center)
          pdf.font('Helvetica', style: :normal, align: :center)
        end
        private_class_method :add_header_config
      end
    end
  end
end
