module BrInvoicesPdf
  module Cfe
    module Parser
      class ProductsData
        include BaseParser

        def execute(xml)
          {
            products: product_params(xml.locate('infCFe/det')),
            total_items: xml.locate('infCFe/det').last.attributes[:nItem]
          }[:products]
        end

        private

        def product_params(node_products)
          products = []
          node_products.each do |element|
            product = {}
            product[:code] = node_locate(element, 'cProd')
            product[:description] = node_locate(element, 'xProd')
            product[:cfop] = node_locate(element, 'CFOP')
            product[:quantity] = node_locate(element, 'qCom')
            product[:unit_label] = node_locate(element, 'uCom')
            product[:total_value] = node_locate(element, 'vProd')
            product[:unit_value] = node_locate(element, 'vUnCom')
            product[:item_value] = node_locate(element, 'vItem')
            products << product
          end
          products
        end
      end
    end
  end
end
