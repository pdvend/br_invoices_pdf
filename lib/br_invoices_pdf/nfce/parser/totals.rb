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
          {
            items: Products.execute(xml).count,
            subtotal: locate_element(xml, "#{total_root_path(xml)}/vProd"),
            discounts: locate_element(xml, "#{total_root_path(xml)}/vDesc"),
            total: locate_element(xml, "#{total_root_path(xml)}/vNF"),
            cashback: '0.00'
          }
        end
      end
    end
  end
end
