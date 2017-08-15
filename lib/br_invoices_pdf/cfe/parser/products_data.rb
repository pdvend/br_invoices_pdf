module BrInvoicesPdf
  module Cfe
    module Parser
      module ProductsData
        extend BaseParser

        module_function

        FIELDS = { code: 'cProd',
                   description: 'xProd',
                   cfop: 'CFOP',
                   quantity: 'qCom',
                   unit_label: 'uCom',
                   total_value: 'vProd',
                   unit_value: 'vUnCom',
                   item_value: 'vItem' }.freeze

        def execute(xml)
          node_products = xml.locate('infCFe/det')
          products_params(node_products) if node_products
        end

        def products_params(node_products)
          products = []
          node_products.each do |element|
            products << product_by(element)
          end
          products
        end
        private_class_method :products_params

        def product_by(element)
          {}.tap do |product|
            FIELDS.each do |key, field|
              product[key] = node_locate(element, field)
            end
          end
        end
        private_class_method :product_by
      end
    end
  end
end
