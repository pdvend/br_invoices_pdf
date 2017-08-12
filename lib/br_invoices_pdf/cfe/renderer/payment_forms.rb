module BrInvoicesPdf
  module Cfe
    module Renderer
      class PaymentForms
        include BaseRenderer

        def execute(pdf, data)
          width = page_content_width(pdf)
          table_data = payments_table_data(data, width)

          pdf.font_size(6) do
            pdf.table(table_data, width: width) do |table|
              table.columns([0, 1]).valign = :center
              table.columns(1).align = :right
              table.row([0, table_data.size - 1]).font_style = :bold
              table.row([0, table_data.size - 2]).font_style = :bold
            end
          end

          pdf.move_down(5)
        end

        private

        PAYMENTS_TABLE_BASE_DATA = [['FORMA DE PAGAMENTO', 'VALOR']].freeze
        def payments_table_data(data, _width)
          payments_data = data[:payments].reduce(PAYMENTS_TABLE_BASE_DATA) do |result, cur|
            result + [[cur[:type], format_currency(BigDecimal(cur[:amount]))]]
          end

          payments_data.push(['TROCO', format_currency(BigDecimal(data[:payment][:cash_back]))])
          payments_data.push(['TOTAL', format_currency(BigDecimal(data[:payment][:payd]))])

          payments_data
        end
      end
    end
  end
end
