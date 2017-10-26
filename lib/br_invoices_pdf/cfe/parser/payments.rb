# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Parser
      module Payments
        extend Util::XmlLocate

        module_function

        def execute(xml)
          node_payments = xml.locate('infCFe/pgto')

          return unless node_payments
          payments_by_nodes(node_payments) if node_payments.any?
        end

        def payments_by_nodes(node_payments)
          node_payments.first.nodes
                       .select { |element| element.value == 'MP' }
                       .map { |element| payment_by(element) }
        end
        private_class_method :payments_by_nodes

        def payment_by(element)
          {
            type: Util::Enum::PAYMENT_TYPES[locate_element(element, 'cMP')],
            amount: locate_element(element, 'vMP')
          }
        end
        private_class_method :payment_by
      end
    end
  end
end
