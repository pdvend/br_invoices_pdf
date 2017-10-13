module BrInvoicesPdf
  module Nfce
    module Parser
      module Payments
        extend Util::XmlLocate

        module_function

        ROOT_PATH = Util::XmlLocate::ROOT_PATH

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
          node_payments = xml.locate("#{ROOT_PATH}/pag")

          node_payments.map(&method(:payment_by))
        end

        def payment_by(element)
          {
            type: PAYMENT_TYPES[locate_element(element, 'tPag')],
            amount: locate_element(element, 'vPag')
          }
        end
        private_class_method :payment_by
      end
    end
  end
end
