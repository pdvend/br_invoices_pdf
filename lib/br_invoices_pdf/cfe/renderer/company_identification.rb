module BrInvoicesPdf
  module Cfe
    module Renderer
      class CompanyIdentification
        include BaseRenderer

        def execute(pdf, data)
          pdf_setup(pdf) do
            company_names(pdf, data)
            company_infos(pdf, data)

            pdf.text(format_address(data[:company_attributes][:address]), align: :center)
          end
        end

        private

        def pdf_setup(pdf)
          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do
            pdf.pad(10) do
              pdf.indent(10, 10) do
                yield
              end
            end
            pdf.stroke_bounds
          end
        end

        def company_names(pdf, data)
          pdf.text(data[:company_attributes][:company_name], align: :center)
          pdf.text(data[:company_attributes][:trading_name], align: :center)
        end

        def company_infos(pdf, data)
          pdf.text('CNPJ: ' + format_cnpj(data[:company_attributes][:cnpj]), align: :center)
          pdf.text('Inscrição Estadual: ' + data[:company_attributes][:ie], align: :center)
        end
      end
    end
  end
end
