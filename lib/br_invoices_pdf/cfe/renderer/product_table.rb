module BrInvoicesPdf
  module Cfe
    module Renderer
      class ProductTable
        include BaseRenderer

        def execute(pdf, data)
          width = page_content_width(pdf)
          table_data = product_table_data(data)

          pdf.font_size(6) do
            pdf.table(table_data, width: width) do |table|
              table.row(0).font_style = :bold
              table.row(0).align = :center

              table.columns(0..5).valign = :center
              table.columns([2, 4, 5]).align = :right
              table.column(3).align = :center

              table_widths(table)
            end
          end

          pdf.move_down(5)
        end

        private

        def table_widths(table)
          width = table.width
          table.column(0).width = width * 0.16
          table.column(2).width = width * 0.13
          table.column(3).width = width * 0.13
          table.column(4).width = width * 0.135
          table.column(5).width = width * 0.135
        end

        PRODUCT_TABLE_BASE_DATA = [['CÓD.', 'DESCRIÇÃO', 'QTD.', 'UND.', 'V.UNIT', 'V.TOT']].freeze
        def product_table_data(data)
          data[:products].reduce(PRODUCT_TABLE_BASE_DATA) do |result, cur|
            result + [[
              cur[:code],
              cur[:description],
              format_number(BigDecimal(cur[:quantity])),
              cur[:unit_label],
              format_currency(BigDecimal(cur[:unit_value])),
              format_currency(BigDecimal(cur[:total_value]))
            ]]
          end
        end
      end
    end
  end
end
