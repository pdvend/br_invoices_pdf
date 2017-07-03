module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      AVAILABLE_UF = { '35' => 'São Paulo' }.freeze
      SAT_QRCODE_SEPARATOR   = '|'.freeze
      def parse(xml)
        # Retornar uma hash com todos os atributos necessarios
        {
          uf: AVAILABLE_UF[xml.locate('infCFe/ide/cUF').first_text],
          access_key: xml.locate('Signature/SignedInfo').first.nodes.last.attributes[:URI]
          sat_number: xml.locate('infCFe/ide/nserieSAT').first.text,
          emission_date: xml.locate('infCFe/ide/dEmi').first.text,
          emission_type: xml.locate('infCFe/ide/hEmi').first.text,
          document_qr_code_signature: xml.locate('infCFe/ide/assinaturaQRCODE').first.text,
          fisco_obs: xml.locate('infCFe/infAdic').first.nodes.map(&:attributes),
          pdv_number: xml.locate('infCFe/ide/numeroCaixa').first.text,
          company_name: xml.locate('infCFe/emit/xNome').first.text,
          company_address: company_address_params,
          trading_name: xml.locate('infCFe/emit/xFant').first.text,
          zipcode: xml.locate('infCFe/emit/enderEmit/CEP').first.text,
          cpnj: xml.locate('infCFe/ide/CNPJ').first.text,
          ie: xml.locate('infCFe/emit/enderEmit/IE').first.text,
          im: xml.locate('infCFe/emit/enderEmit/IM').first.text,
          ncfe_number: xml.locate('infCFe/ide/enderEmit/nCFe').first.text,
          products: product_params(xml.locate('infCFe/det')),
          total: xml.locate('infCFe/total/vCFe').first.text,
          total_items: xml.locate('infCFe/det').last.attributes[:nItem],
          discount: xml.locate('infCFe/total/ICMSTot/vDesc').first.text,
          cpf: xml.locate('infCFe/dest/CPF').first.text,
          tributes_value: xml.locate('infCFe/dest/CPF').first.text,
          payment: {
            cash_back: xml.locate('infCFe/pgto/troco/vTroco').first.text,
            payd: xml.locate('infCFe/pgto/troco/vMP').first.text
          },
          approximate_value_of_taxex: xml.locate('infCFe/total/vCFeLei12741').first.text
        }
      end

      def fisco_obs
        {
          text: xml.locate('infCFe/infAdic/obsFisco').first.nodes.first.text,
          field: xml.locate('infCFe/infAdic/obsFisco').first.attributes
        }
      end

      def company_address_params
        {
          public_place: xml.locate('infCFe/emit/enderEmit/xLgr').first.value,
          number: xml.locate('infCFe/emit/enderEmit/nro').first.value,
          complement: xml.locate('infCFe/emit/enderEmit/xCpl').first.value,
          city: xml.locate('infCFe/emit/enderEmit/xMun').first.value,
          neighborhood: xml.locate('infCFe/emit/enderEmit/xBairro').first.value,
          cep: xml.locate('infCFe/emit/enderEmit/CEP').first.value
        }
      end

      def product_params(node_products)
        products = []
        product = {}
        node_products.each do |node_product|
          product[:code] = node_product.first.locate('cProd')
          product[:description] = node_product.first.locate('xProd')
          product[:quantity] = node_product.first.locate('qCom')
          product[:unit_label] = node_product.first.locate('qCom')
          product[:total_value] = node_product.first.locate('vProd')
          product[:unit_value] = node_product.first.locate('vUnCom')
          product[:discount] = node_product.first.locate('vDesc')
          products << product
        end
        products
      end
    end
  end
end
