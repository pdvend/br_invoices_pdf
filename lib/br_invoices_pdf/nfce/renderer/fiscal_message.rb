# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module FiscalMessage
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            emission_details(pdf, data)
            emission_date(pdf, data)
            consult_key(pdf, data[:emission_details][:access_key])
          end
        end

        def consult_key(pdf, key)
          pdf.text("CHAVE DE ACESSO:\n#{key.scan(/.{1,4}/).join(' ')}", align: :center)
        end
        private_class_method :consult_key

        # :reek:FeatureEnvy
        def emission_date(pdf, data)
          details = data[:emission_details]
          text = "Emissão: #{format_date(details[:emission_timestamp])} - Via Consumidor\n\n"
          pdf.text(text, align: :center)
          key_text = "Consulte pela chave de acesso em: #{details[:check_url]} \n\n"
          pdf.text(key_text, align: :center)
        end
        private_class_method :emission_date

        # :reek:FeatureEnvy
        def emission_details(pdf, data)
          pdf.text("Mensagem Fiscal\n\n", style: :italic)
          details = data[:emission_details]
          text = "Número: #{details[:number]} - Série: #{details[:serie]}\n\n"
          pdf.text(text, align: :center)
        end
        private_class_method :emission_details
      end
    end
  end
end
