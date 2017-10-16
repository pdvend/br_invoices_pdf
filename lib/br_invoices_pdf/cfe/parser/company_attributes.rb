# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Parser
      module CompanyAttributes
        extend Util::XmlLocate

        module_function

        SEFAZ_STATE_CODES = {
           '11' => 'RO',  '12' => 'AC',  '13' => 'AM',  '14' => 'RR',  '15' => 'PA',
           '16' => 'AP',  '17' => 'TO',  '21' => 'MA',  '22' => 'PI',  '23' => 'CE',
           '24' => 'RN',  '25' => 'PB',  '26' => 'PE',  '27' => 'AL',  '28' => 'SE',
           '29' => 'BA',  '31' => 'MG',  '32' => 'ES',  '33' => 'RJ',  '35' => 'SP',
           '41' => 'PR',  '42' => 'SC',  '43' => 'RS',  '50' => 'MS',  '51' => 'MT',
           '52' => 'GO',  '53' => 'DF'
        }.freeze

        def execute(xml)
          {
            company_name: locate_element(xml, 'infCFe/emit/xNome'),
            address: company_address_params(xml),
            trading_name: locate_element(xml, 'infCFe/emit/xFant'),
            zipcode: locate_element(xml, 'infCFe/emit/enderEmit/CEP'),
            cnpj: locate_element(xml, 'infCFe/ide/CNPJ'),
            ie: locate_element(xml, 'infCFe/emit/IE'),
            im: locate_element(xml, 'infCFe/emit/IM')
          }
        end

        def company_address_params(xml)
          {
            public_place: locate_element(xml, 'infCFe/emit/enderEmit/xLgr'),
            number: locate_element(xml, 'infCFe/emit/enderEmit/nro'),
            complement: locate_element(xml, 'infCFe/emit/enderEmit/xCpl'),
            city: locate_element(xml, 'infCFe/emit/enderEmit/xMun'),
            neighborhood: locate_element(xml, 'infCFe/emit/enderEmit/xBairro'),
            cep: locate_element(xml, 'infCFe/emit/enderEmit/CEP'),
            state: SEFAZ_STATE_CODES[locate_element(xml, 'infCFe/ide/cUF')]
          }
        end
        private_class_method :company_address_params
      end
    end
  end
end
