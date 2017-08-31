module BrInvoicesPdf
  module Cfe
    module Renderer
      # :reek:DataClump
      module CompanyIdentification
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          attributes = data[:company_attributes]
          pdf_setup(pdf) do
            company_params(pdf, attributes)
          end
        end

        # :reek:FeatureEnvy
        def company_params(pdf, data)
          pdf.text(data[:trading_name], align: :center)
          pdf.text(data[:company_name], align: :center)
          pdf.text(format_address(data[:address]), align: :center)
          insert_fiscal_numbers(pdf, data)
        end
        private_class_method :company_params

        # :reek:FeatureEnvy
        def insert_fiscal_numbers(pdf, data)
          pdf.text("CNPJ: #{format_cnpj(data[:cnpj])}", align: :center)
          pdf.text("Inscrição Estadual: #{data[:ie]}", align: :center)
          pdf.text("Inscrição Municipal: #{data[:im]}", align: :center)
        end
        private_class_method :insert_fiscal_numbers
      end
    end
  end
end
