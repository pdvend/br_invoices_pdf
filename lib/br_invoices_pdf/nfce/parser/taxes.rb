# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Taxes
        extend Util::XmlLocate

        module_function

        def execute(xml)
          # TODO: verificar como calcular esses valores e escrever o teste
          {
            amount: BigDecimal('2.88'),
            percent: '7,33%'
          }
        end
      end
    end
  end
end
