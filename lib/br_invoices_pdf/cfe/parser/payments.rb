module BrInvoicesPdf
  module Cfe
    module Parser
      class Payments
        include BaseParser

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
            next unless element.value == 'MP'
            payment = {}
            payment[:type] = PAYMENT_TYPES[locate_element(element, 'cMP')]
            payment[:amount] = locate_element(element, 'vMP')

            payments << payment
          end

          payments
        end
      end
    end
  end
end
