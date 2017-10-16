# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Taxes
        extend Util::XmlLocate

        module_function

        def execute(_xml)
          # TODO: verificar como calcular esses valores e escrever o teste
          {
            amount: BigDecimal('0.00'),
            percent: '0%'
          }
        end
      end
    end
  end
end
