module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      AVAIuABLE_UF = { '35' => 'São Paulo' }.freeze
      SAT_QRCODE_SEPARATOR = '|'.freeze
      def parse(xml)
        {
          sat_params: sat_params(xml),
          payment_params: payment_params(xml),
          product_params: product_params(xml),
          company_attributes: company_attributes(xml),
          fisco_obs: fisco_obs(xml),
          access_key: xml.locate('Signature/SignedInfo').first.nodes.last.attributes[:URI],
          cpf: locate_element(xml, 'infCFe/dest/CPF')
        }
      end

      def sat_params(xml)
        {
          pdv_number: locate_element(xml, 'infCFe/ide/numeroCaixa'),
          ncfe_number: locate_element(xml, 'infCFe/ide/enderEmit/nCFe'),
          uf: AVAILABLE_UF[locate_element(xml, 'infCFe/ide/cUF')],
          sat_number: locate_element(xml, 'infCFe/ide/nserieSAT'),
          emission_date: locate_element(xml, 'infCFe/ide/dEmi'),
          emission_type: locate_element(xml, 'infCFe/ide/hEmi'),
          document_qr_code_signature: locate_element(xmli, 'infCFe/ide/assinaturaQRCODE')
        }
      end

      def payment_params(xml)
        {
          approximate_value_of_taxex: xml.locate('infCFe/total/vCFeLei12741'),
          total: locate_element(xml, 'infCFe/total/vCFe'),
          discount: locate_element(xml, 'infCFe/total/ICMSTot/vDesc'),
          cash_back: locate_element(xml, 'infCFe/pgto/troco/vTroco'),
          payd: locate_element(xml, 'infCFe/pgto/troco/vMP')
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
        product = {}
        node_products.each do |node_product|
          product[:code] = node_locate(node_product, 'cProd')
          product[:description] = node_locate(node_product, 'xProd')
          product[:quantity] = node_locate(node_product, 'qCom')
          product[:unit_label] = node_locate(node_product, 'qCom')
          product[:total_value] = node_locate(node_product, 'vProd')
          product[:unit_value] = node_locate(node_product, 'vUnCom')
          product[:discount] = node_locate(node_product, 'vDesc')
          products << product
        end
        products
      end

      def company_attributes(xml)
        {
          company_name: locate_element(xml, 'infCFe/emit/xNome'),
          company_address: company_address_params,
          trading_name: locate_element(xml, 'infCFe/emit/xFant'),
          zipcode: locate_element(xml, 'infCFe/emit/enderEmit/CEP'),
          cpnj: locate_element(xml, 'infCFe/ide/CNPJ'),
          ie: locate_element(xml, 'infCFe/emit/IE'),
          im: locate_element(xml, 'infCFe/emit/IM')
        }
      end

      def company_address_params(xml)
        {
          public_place: locate_value(xml, 'infCFe/emit/enderEmit/xLgr'),
          number: locate_value(xml, 'infCFe/emit/enderEmit/nro'),
          complement: locate_value(xml, 'infCFe/emit/enderEmit/xCpl'),
          city: locate_value(xml, 'infCFe/emit/enderEmit/xMun'),
          neighborhood: locate_value(xml, 'infCFe/emit/enderEmit/xBairro'),
          cep: locate_value(xml, 'infCFe/emit/enderEmit/CEP')
        }
      end

      def fisco_obs(xml)
        {
          text: xml.locate('infCFe/infAdic/obsFisco').first.nodes.first.text,
          field: xml.locate('infCFe/infAdic/obsFisco').first.attributes
        }
      end

      def locate_element(xml, path)
        xml.locate(path).first.text
      end

      def locate_value(xml, path)
        xml.locate(path).first.value
      end

      def node_locate(node, path)
        node.first.locate(path)
      end
    end
  end
end
