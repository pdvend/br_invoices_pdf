# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module Enum
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
    end
  end
end
