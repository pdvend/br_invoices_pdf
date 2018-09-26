# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module ProconInfo
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          procon_message = data[:additional_variables][:procon_message]

          return if ['', nil].include? procon_message

          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            procon_message(pdf, procon_message)
          end
        end

        # :reek:FeatureEnvy
        def procon_message(pdf, message)
          pdf.text("Mensagem de Interesse do Contribuente:\n\n", style: :italic)
          text = "#{message}\n\n"
          pdf.text(text, align: :center)
        end
        private_class_method :procon_message
      end
    end
  end
end
