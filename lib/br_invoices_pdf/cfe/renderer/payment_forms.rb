# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Renderer
      module PaymentForms
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          execute_payment_form(pdf, payments_table_data(data))
        end

        def render_table(pdf, table_data, width)
          pdf.table(table_data, width: width) do |table|
            format_table(table, table_data)
          end
        end
        private_class_method :render_table

        # :reek:FeatureEnvy
        def format_table(table, table_data)
          table.columns([0, 1]).valign = :center
          table.columns(1).align = :right
          table_size = table_data.size
          table.row([0, table_size - 1]).font_style = :bold
          table.row([0, table_size - 2]).font_style = :bold
        end
        private_class_method :format_table

        def payments_table_data(data)
          payments_data = mount_payment_data(data)

          add_default_values(payments_data, data[:totals])
        end
        private_class_method :payments_table_data

        def add_default_values(payments_data, data)
          payments_data.push(['TROCO', format_currency(data[:cashback])])
          payments_data.push(['TOTAL', format_currency(data[:paid])])
        end
        private_class_method :add_default_values
      end
    end
  end
end
