module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      # atributos
      # city -> emit,enderEmit
      # company_state -> ?
      # cpf -> ide,NFCE
      # total de items em RS->
      # valor total
      # desconto total
      # total bruto de items
      # total desconto/acressimo sobre item
      # obs do fisco
      # note
      # valor aproximado de tributos
      # sat number
      # hora da emissao
      # chave de acesso
      # codigo de barras 1,2 e qrcode
      def parse(_xml)
        # Retornar uma hash com todos os atributos necessarios
        {
          company_name: xml.locate('infCFe/emit/xNome').first.text,
          trading_name: xml.locate('infCFe/emit/xFant').first.text
          company_address: {},
          zipcode: xml.locate('infCFe/emit/enderEmit/CEP').first.text
          cpnj: xml.locate('infCFe/ide/CNPJ').first.text,
          ie: xml.locate('infCFe/emit/enderEmit/IE').first.text,
          im: xml.locate('infCFe/emit/enderEmit/IM').first.text,
          ncfe_number: xml.locate('infCFe/ide/enderEmit/nCFe').first.text,
          products: product_params(xml.locate('infCFe/det')),
          total: xml.locate('infCFe/total/vProd').first.text
          cash_back: xml.locate('infCFe/pgto/troco/vProd').first.text
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
          products << product
        end
        products
      end


    end
  end
end
