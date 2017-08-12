module BrInvoicesPdf
  module Cfe
    module Renderer
      class CompanyIdentification
        include BaseRenderer

        def execute(pdf, data)
          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |_box|
            pdf.pad(10) do
              pdf.indent(10, 10) do
                pdf.text(data[:company_attributes][:company_name], align: :center)
                pdf.text(data[:company_attributes][:trading_name], align: :center)

                pdf.text('CNPJ: ' + format_cnpj(data[:company_attributes][:cnpj]), align: :center)
                pdf.text('Inscrição Estadual: ' + data[:company_attributes][:ie], align: :center)
                pdf.text(format_address(data[:company_attributes][:address]), align: :center)
              end
            end

            pdf.stroke_bounds
          end
        end
      end
    end
  end
end
