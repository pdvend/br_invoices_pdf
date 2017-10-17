# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Totals
        extend Util::XmlLocate

        module_function

        TOTAL_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/total/ICMSTot"

        def execute(xml)
          {
            items: Products.execute(xml).count,
            subtotal: locate_element(xml, "#{TOTAL_ROOT_PATH}/vProd"),
            discounts: locate_element(xml, "#{TOTAL_ROOT_PATH}/vDesc"),
            total: locate_element(xml, "#{TOTAL_ROOT_PATH}/vNF"),
            cashback: '0.00'
          }
        end
      end
    end
  end
end
