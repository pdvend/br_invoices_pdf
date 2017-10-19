# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Renderer
      module Totals
        extend Util::BaseRenderer
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          insert_box_info(pdf, data)

          pdf.move_down(5)
        end

        def box_info(data_payment)
          [
            ['Total bruto dos itens', format_currency(data_payment[:total_price])],
            ['Desconto', format_currency(data_payment[:discount])],
            ['Total', format_currency(data_payment[:total])]
          ]
        end
        private_class_method :box_info
      end
    end
  end
end
