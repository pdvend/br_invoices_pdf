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
          cpf = data[:cpf]
          cnpj = data[:cnpj]
          if cpf.to_s.empty?
            if cnpj.to_s.empty?
              'CONSUMIDOR NAO IDENTIFICADO'
            else
              'CONSUMIDOR: ' + format_cnpj(cnpj)
            end
          else
            'CONSUMIDOR: ' + format_cpf(cpf)
          end
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
