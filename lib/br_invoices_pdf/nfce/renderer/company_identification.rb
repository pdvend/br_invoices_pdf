# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      # :reek:DataClump
      module CompanyIdentification
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          attributes = data[:company]
          pdf_setup(pdf) do
            company_params(pdf, attributes)
          end
        end

        # :reek:FeatureEnvy
        def company_params(pdf, data)
          pdf.text(data[:name], align: :center)
          pdf.text(format_address(data[:address]), align: :center)
          insert_fiscal_numbers(pdf, data)
        end
        private_class_method :company_params

        # :reek:FeatureEnvy
        def insert_fiscal_numbers(pdf, data)
          pdf.text("CNPJ: #{format_cnpj(data[:cnpj])}", align: :center)
          pdf.text("Inscrição Estadual: #{data[:state_number]}", align: :center)
        end
        private_class_method :insert_fiscal_numbers
      end
    end
  end
end
