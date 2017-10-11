module BrInvoicesPdf
  module Cfe
    module Parser
      module Payments
        extend BaseParser

        module_function

        PAYMENT_TYPES = {
          '01' => 'Dinheiro',
          '02' => 'Cheque',
          '03' => 'Cartão de Crédito',
          '04' => 'Cartão de Débito',
          '05' => 'Crédito Loja',
          '10' => 'Vale Alimentação',
          '11' => 'Vale Refeição',
          '12' => 'Vale Presente',
          '13' => 'Vale Combustível',
          '99' => 'Outros'
        }.freeze

        def execute(xml)
          node_payments = xml.locate('infCFe/pgto')

          payments_by_nodes(node_payments) if node_payments && node_payments.any?
        end

        def payments_by_nodes(node_payments)
          node_payments.first.nodes
                       .select { |element| element.value == 'MP' }
                       .map { |element| payment_by(element) }
        end
        private_class_method :payments_by_nodes

        def payment_by(element)
          {
            type: PAYMENT_TYPES[locate_element(element, 'cMP')],
            amount: locate_element(element, 'vMP')
          }
        end
        private_class_method :payment_by
      end
    end
  end
end
