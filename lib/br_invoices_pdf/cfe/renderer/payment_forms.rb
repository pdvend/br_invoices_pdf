module BrInvoicesPdf
  module Cfe
    module Renderer
      module PaymentForms
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          width = page_content_width(pdf)

          pdf.font_size(6) do
            pdf.table(payments_table_data(data), width: width) do |table|
              format_table(table)
            end
          end

          pdf.move_down(5)
        end

        # :reek:FeatureEnvy
        def format_table(table)
          table.columns([0, 1]).valign = :center
          table.columns(1).align = :right
          table_size = table_data.size
          table.row([0, table_size - 1]).font_style = :bold
          table.row([0, table_size - 2]).font_style = :bold
        end

        PAYMENTS_TABLE_BASE_DATA = [['FORMA DE PAGAMENTO', 'VALOR']].freeze
        def payments_table_data(data)
          payments_data = data[:payments].reduce(PAYMENTS_TABLE_BASE_DATA) do |result, cur|
            result + [[cur[:type], format_currency(BigDecimal(cur[:amount]))]]
          end

          add_default_values(payments_data, data[:payment])
        end
        private_class_method :payments_table_data

        def add_default_values(payments_data, data)
          payments_data.push(['TROCO', format_currency(BigDecimal(data[:cash_back]))])
          payments_data.push(['TOTAL', format_currency(BigDecimal(data[:payd]))])
        end
        private_class_method :add_default_values
      end
    end
  end
end
