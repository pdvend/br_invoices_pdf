module BrInvoicesPdf
  module Nfce
    class Renderer
      def pdf(data, options)
        Prawn::Document.new(options) do |pdf|
          add_company_identification(pdf, data)
          add_header(pdf)
          add_product_table(pdf, data)
        end
      end

      private

      def add_company_identification(pdf, data)
        pdf.bounding_box([0, pdf.cursor], width: page_width(pdf)) do |box|
          pdf.pad(10) do
            pdf.indent(100, 100) do
              pdf.text(data[:company][:name])
              pdf.text("CNPJ: " + format_cnpj(data[:company][:cnpj]))
              pdf.text("Inscrição Estadual: " + data[:company][:state_number])
              pdf.text(format_address(data[:company][:address]))
            end
          end

          pdf.stroke_bounds
        end
      end

      def add_header(pdf)
        pdf.bounding_box([0, pdf.cursor], width: page_width(pdf)) do |box|
          pdf.pad(10) do
            pdf.indent(10, 10) do
              pdf.font("Helvetica", style: :bold)
              pdf.text("DANFE NFC-e - Documento Auxiliar da Nota Fiscal Eletrônica para Consumidor Final\n\n", align: :center)
              pdf.font("Helvetica", style: :normal)
              pdf.text("Não permite aproveitamento de crédito de ICMS", align: :center)
            end
          end

          pdf.stroke_bounds
        end
        pdf.move_down(5)
      end

      def add_product_table(pdf, data)
        table_data = product_table_data(data)
        pdf.table(table_data, width: page_width(pdf)) do |table|
          table.column(0).align = :left
          table.column(1).align = :left
          table.column(2).align = :right
          table.column(3).align = :center
          table.column(4).align = :right
          table.column(5).align = :right

          table.row(0).valign = :center
          table.row(0).align = :center
          table.row(0).font_style = :italic
        end
        pdf.move_down(5)
      end

      PRODUCT_TABLE_BASE_DATA =[['CÓD.', 'DESCRIÇÃO', { content: 'QTD.', overflow: :shrink_to_fit }, 'UND.', 'V. UNIT.', 'V. TOTAL']].freeze
      def product_table_data(data)
        data[:products].reduce(PRODUCT_TABLE_BASE_DATA) do |result, cur|
          result + [[
            cur[:code],
            cur[:description],
            format_number(cur[:quantity]),
            cur[:unit_label],
            format_currency(cur[:unit_value]),
            format_currency(cur[:total_value])
          ]]
        end
      end

      CNPJ_FORMAT = "%d.%d.%d/%d-%d"
      def format_cnpj(cnpj)
        CNPJ_FORMAT % [cnpj[0,2], cnpj[2,3], cnpj[5,3], cnpj[8,4], cnpj[12,2]]
      end

      ADDRESS_FORMAT = "%s, %s, %s, %s/%s"
      def format_address(address)
        ADDRESS_FORMAT % [:streetname, :number, :district, :city, :state].map(&address.method(:[]))
      end

      def format_currency(num)
        num.truncate.to_s.reverse.split(/.../).join(',').reverse + ('.%02d' % (num.frac * 100).truncate)
      end

      def format_number(num, prec: 4)
        num.truncate.to_s + (prec > 0 ? (".%0#{prec}d" % (num.frac * 10 ** prec).truncate) : "")
      end

      def page_width(pdf)
        page_size(pdf).first
      end

      def page_height(pdf)
        page_size(pdf).last
      end

      def page_size(pdf)
        s = pdf.page.size
        s = PDF::Core::PageGeometry::SIZES[s].clone unless s.is_a?(Array)

        [
          s[0] - pdf.page.margins[:left] - pdf.page.margins[:right],
          s[1] - pdf.page.margins[:top] - pdf.page.margins[:bottom]
        ]
      end
    end
  end
end
