module BrInvoicesPdf
  module Cfe
    module Renderer
      class FiscoInfo
        include BaseRenderer

        def execute(pdf, data)
          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |_box|
            pdf.pad(10) do
              pdf.indent(10, 10) do
                pdf.text("Observações do fisco\n\n", style: :italic)

                data[:fisco_obs].each do |element|
                  pdf.text(element[:field] + ': ' + element[:text], align: :center)
                end
              end
            end

            pdf.stroke_bounds
          end
        end
      end
    end
  end
end
