module BrInvoicesPdf
  module Cfe
    module Renderer
      module FiscoInfo
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do
            pdf.pad(10) do
              pdf.indent(10, 10) do
                add_fisco_obs(pdf, data[:fisco_obs])
              end
            end

            pdf.stroke_bounds
          end
        end

        def add_fisco_obs(pdf, fisco_obs)
          pdf.text("Observações do fisco\n\n", style: :italic)

          fisco_obs.each do |element|
            pdf.text(element[:field] + ': ' + element[:text], align: :center)
          end
        end
        private_class_method :add_fisco_obs
      end
    end
  end
end
