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
          payments = []
          node_payments = xml.locate('infCFe/pgto')

          node_payments[0].nodes.each do |element|
            payments << payment_by(element) if element.value == 'MP'
          end

          payments
        end

        def payment_by(element)
          {
            type: PAYMENT_TYPES[locate_element(element, 'cMP')],
            amount: locate_element(element, 'vMP')
          }
        end
      end
    end
  end
end
