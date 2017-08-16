module BrInvoicesPdf
  module Cfe
    module Renderer
      module Header
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          cpf = cpf_vlue(data[:cpf])

          pdf_setup(pdf) do
            add_header_config(pdf, data, cpf)
          end

          pdf.move_down(5)
        end

        def cpf_vlue(cpf)
          cpf ? 'CONSUMIDOR:' + cpf : 'CONSUMIDOR NAO IDENTIFICADO'
        end
        private_class_method :cpf_vlue

        def add_header_config(pdf, data, cpf)
          pdf.font('Helvetica', style: :bold)
          pdf.text("Extrato: #{data[:document_number]}", align: :center)
          pdf.text(cpf, align: :center)
          pdf.text('CUPOM FISCAL ELETRONICO - SAT', align: :center)
          pdf.font('Helvetica', style: :normal, align: :center)
        end
        private_class_method :add_header_config
      end
    end
  end
end
