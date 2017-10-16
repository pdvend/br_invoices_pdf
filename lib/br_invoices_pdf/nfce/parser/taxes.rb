# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Taxes
        extend Util::XmlLocate

        module_function

        def execute(xml)
          # TODO: verificar como calcular esses valores e escrever o teste
          amount = '19.00'
          {
            amount: amount,
            percent: percent_by_amount(xml, amount)
          }
        end

        def percent_by_amount(xml, amount)
          total = locate_element(xml, "#{Util::XmlLocate::ROOT_PATH}/total/ICMSTot/vNF")
          (BigDecimal.new(amount) / BigDecimal.new(total)) * 100.0
        end
        private_class_method :percent_by_amount
      end
    end
  end
end
