module BrInvoicesPdf
  module Cfe
    module Renderer
      module ProductTable
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          table_data = product_table_data(data)

          pdf.font_size(6) do
            format_table(pdf, table_data)
          end

          pdf.move_down(5)
        end

        def format_table(pdf, table_data)
          width = page_content_width(pdf)
          pdf.table(table_data, width: width) do |table|
            format_row(table.row(0))
            format_columns(table)
          end
        end
        private_class_method :format_table

        def format_row(row)
          row.font_style = :bold
          row.align = :center
        end
        private_class_method :format_row

        # :reek:FeatureEnvy
        def format_columns(table)
          table.columns(0..5).valign = :center
          table.columns([2, 4, 5]).align = :right
          table.column(3).align = :center
          table_widths(table, table.width)
        end
        private_class_method :format_columns

        # :reek:FeatureEnvy
        def table_widths(table, width)
          table.column(0).width = width * 0.16
          table.columns([2, 3]).width = width * 0.155
          table.column([4, 5]).width = width * 0.135
        end
        private_class_method :table_widths

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
        private_class_method :product_table_data
      end
    end
  end
end
