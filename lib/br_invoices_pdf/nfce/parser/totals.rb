# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Totals
        extend Util::XmlLocate

        module_function

        def total_root_path(xml)
          "#{root_path(xml)}/total/ICMSTot"
        end

        def execute(xml)
          root_path = total_root_path(xml)

          {
            items: Products.execute(xml).count,
            subtotal: locate_element(xml, "#{root_path}/vProd"),
            discounts: locate_element(xml, "#{root_path}/vDesc"),
            total: locate_element(xml, "#{root_path}/vNF"),
            cashback: '0.00'
          }
        end
      end
    end
  end
end
