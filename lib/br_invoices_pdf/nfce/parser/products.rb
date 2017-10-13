module BrInvoicesPdf
  module Nfce
    module Parser
      module Products
        extend Util::XmlLocate

        module_function

        ROOT_PATH = Util::XmlLocate::ROOT_PATH

        FIELDS = { code: 'cProd',
                   description: 'xProd',
                   quantity: 'qCom',
                   unit_label: 'uCom',
                   unit_value: 'vUnCom',
                   total_value: 'vProd' }.freeze

        def execute(xml)
          node_products = xml.locate("#{ROOT_PATH}/det")
          products_params(node_products) if node_products
        end

        def products_params(node_products)
          node_products.map(&method(:product_by))
        end
        private_class_method :products_params

        def product_by(element)
          FIELDS
            .map { |(key, field)| [key, node_locate(element, field).force_encoding('UTF-8'.freeze)] }
            .to_h
        end
        private_class_method :product_by
      end
    end
  end
end
