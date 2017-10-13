module BrInvoicesPdf
  module Nfce
    module Parser
      module Totals
        extend Util::XmlLocate

        module_function

        TOTAL_ROOT_PATH = "#{Util::XmlLocate::ROOT_PATH}/total".freeze

        def execute(xml)
          {
            items: Products.execute(xml).count,
            subtotal: locate_element(xml, "#{TOTAL_ROOT_PATH}/vProd"),
            discounts: locate_element(xml, "#{TOTAL_ROOT_PATH}/vDesc"),
            total: locate_element(xml, "#{TOTAL_ROOT_PATH}/vNF"),
            cashback: nil
          }
        end
      end
    end
  end
end
