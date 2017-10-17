# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Renderer
      module FiscoInfo
        extend BaseRenderer

        module_function

        # :reek:FeatureEnvy
        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text("Observações do fisco\n\n", style: :italic)
            add_fisco_obs(pdf, data[:fisco_obs])
          end
        end

        def add_fisco_obs(pdf, fisco_obs)
          fisco_obs.each do |element|
            pdf.text(element[:field] + ': ' + element[:text], align: :center)
          end
        end
        private_class_method :add_fisco_obs
      end
    end
  end
end
