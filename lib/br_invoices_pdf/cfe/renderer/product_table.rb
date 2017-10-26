# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Renderer
      module ProductTable
        extend Util::BaseRenderer
        extend Util::ProductTable
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          table_data = product_table_data(data)

          pdf.font_size(6) do
            format_table(pdf, table_data)
          end

          pdf.move_down(5)
        end
      end
    end
  end
end
