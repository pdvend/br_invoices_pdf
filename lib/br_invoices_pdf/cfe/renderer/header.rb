module BrInvoicesPdf
  module Cfe
    module Renderer
      class Header
        include BaseRenderer

        def execute(pdf, data)
          cpf = data[:cpf] ? 'CONSUMIDOR:' + data[:cpf] : 'CONSUMIDOR NAO IDENTIFICADO'

          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |_box|
            pdf.pad(10) do
              pdf.indent(10, 10) do
                pdf.font('Helvetica', style: :bold)
                pdf.text("Extrato: #{data[:document_number]}", align: :center)
                pdf.text(cpf, align: :center)
                pdf.text('CUPOM FISCAL ELETRONICO - SAT', align: :center)
                pdf.font('Helvetica', style: :normal, align: :center)
              end
            end

            pdf.stroke_bounds
          end

          pdf.move_down(5)
        end
      end
    end
  end
end
