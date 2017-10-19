# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module ProductTable
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          table_data = product_table_data(data)

          pdf.font_size(6) do
            format_table(pdf, table_data)
          end
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
      end
    end
  end
end
