module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      AVAILABLE_UF = { '35' => 'São Paulo' }.freeze
      SAT_QRCODE_SEPARATOR = '|'.freeze
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

      SEFAZ_STATE_CODES = {
         '11' => 'RO',  '12' => 'AC',  '13' => 'AM',  '14' => 'RR',  '15' => 'PA',
         '16' => 'AP',  '17' => 'TO',  '21' => 'MA',  '22' => 'PI',  '23' => 'CE',
         '24' => 'RN',  '25' => 'PB',  '26' => 'PE',  '27' => 'AL',  '28' => 'SE',
         '29' => 'BA',  '31' => 'MG',  '32' => 'ES',  '33' => 'RJ',  '35' => 'SP',
         '41' => 'PR',  '42' => 'SC',  '43' => 'RS',  '50' => 'MS',  '51' => 'MT',
         '52' => 'GO',  '53' => 'DF'
      }.freeze

      def parse(xml)
        {
          sat_params: sat_params(xml),
          document_number: locate_element(xml, 'infCFe/ide/nCFe'),
          payment: payment_params(xml),
          payments: payments_params(xml),
          products: products_params(xml)[:products],
          company_attributes: company_attributes(xml),
          fisco_obs: fisco_obs(xml),
          access_key: xml.locate('Signature/SignedInfo').first.nodes.last.attributes[:URI],
          cpf: locate_element(xml, 'infCFe/dest/CPF')
        }
      end

      def sat_params(xml)
        {
          pdv_number: locate_element(xml, 'infCFe/ide/numeroCaixa'),
          ncfe_number: locate_element(xml, 'infCFe/ide/nCFe'),
          uf: AVAILABLE_UF[locate_element(xml, 'infCFe/ide/cUF')],
          sat_number: locate_element(xml, 'infCFe/ide/nserieSAT'),
          emission_date: locate_element(xml, 'infCFe/ide/dEmi'),
          emission_hour: locate_element(xml, 'infCFe/ide/hEmi'),
          document_qr_code_signature: locate_element(xml, 'infCFe/ide/assinaturaQRCODE')
        }
      end

      def payments_params(xml)
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

      def payment_params(xml)
        {
          approximate_value_of_taxex: locate_element(xml, 'infCFe/total/vCFeLei12741'),
          total: locate_element(xml, 'infCFe/total/vCFe'),
          discount: locate_element(xml, 'infCFe/total/ICMSTot/vDesc'),
          total_price: locate_element(xml, 'infCFe/total/ICMSTot/vProd'),
          cash_back: locate_element(xml, 'infCFe/pgto/vTroco'),
          payd: locate_element(xml, 'infCFe/pgto/MP/vMP')
        }
      end

      def products_params(xml)
        {
          products: product_params(xml.locate('infCFe/det')),
          total_items: xml.locate('infCFe/det').last.attributes[:nItem]
        }
      end

      def product_params(node_products)
        products = []
        node_products.each do |element|
          product = {}
          product[:code] = node_locate(element, 'cProd')
          product[:description] = node_locate(element, 'xProd')
          product[:cfop] = node_locate(element, 'CFOP')
          product[:quantity] = node_locate(element, 'qCom')
          product[:unit_label] = node_locate(element, 'uCom')
          product[:total_value] = node_locate(element, 'vProd')
          product[:unit_value] = node_locate(element, 'vUnCom')
          product[:item_value] = node_locate(element, 'vItem')
          products << product
        end
        products
      end

      def company_attributes(xml)
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

      def fisco_obs(xml)
        xml.locate('infCFe/infAdic/obsFisco').map do |element|
          {
            text: element.nodes.first.text,
            field: element.attributes[:xCampo]
          }
        end
      end

      def locate_element(xml, path)
        element = xml.locate(path).first
        element.nil? ? nil : element.text
      end

      def node_locate(element, path)
        element.nodes.first.locate(path).first.text
      end
    end
  end
end
