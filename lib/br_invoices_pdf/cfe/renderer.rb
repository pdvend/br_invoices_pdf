module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      def pdf(data, options)
        Prawn::Document.new(options) do |pdf|
          pdf.text data[:company_attributes][:company_name]
          pdf.text data[:company_attributes][:trading_name]
          pdf.text 'CNPJ: ' + data[:company_attributes][:cnpj]
          pdf.text 'IE: ' + data[:company_attributes][:ie]
          pdf.text 'IM: ' + data[:company_attributes][:im]
          pdf.text data[:company_attributes][:address][:public_place] + ' ' +
                   data[:company_attributes][:address][:number] + ' ' +
                   data[:company_attributes][:address][:complement] + ' '
                   data[:company_attributes][:address][:city] + ' ' +
                   data[:company_attributes][:address][:neighborhood] + ' '
                   data[:company_attributes][:address][:cep]
          pdf.text '--------------------------------------------------------------'
          pdf.text "Extrato: #{data[:document_number]}"
          pdf.text 'CUPOM FISCAL ELETRONICO - SAT'
          pdf.text '--------------------------------------------------------------'
          if data[:cpf]
            pdf.text 'CONSUMIDOR:' + data[:cpf]
          else
            pdf.text 'CONSUMIDOR NAO IDENTIFICADO'
          end
          pdf.text '--------------------------------------------------------------'
          pdf.text 'quantidade, unidade, valor unitario, valor item, total'
          data[:products].each do |product|
            pdf.text product[:quantity] + product[:unit_label] + product[:description] +
                     product[:unit_value] + product[:total_value]
          end
          pdf.text '--------------------------------------------------------------'
          pdf.text 'Total bruto de itens'
          pdf.text 'R$ ' + data[:payment][:total_price]
          pdf.text 'TOTAL                  R$ ' + data[:payment][:total]
          pdf.text 'PAGO                   R$ ' + data[:payment][:payd]
          pdf.text 'TROCO                  R$ ' + data[:payment][:cash_back]
          pdf.text 'Observações do fisco:'
          data[:fisco_obs].each do |element|
            pdf.text element[:field] + ': ' + element[:text]
          end
          pdf.text '--------------------------------------------------------------'
          pdf.text 'Valor aproximado dos tribustos deste cupom'
          pdf.text 'R$: ' + data[:payment][:approximate_value_of_taxex]
          pdf.text 'Conforme lei federal 12.741/2012'
          pdf.text '--------------------------------------------------------------'
          pdf.text 'SAT Número ' + data[:sat_params][:sat_number]
          time = data[:sat_params][:emission_date] + data[:sat_params][:emission_hour]
          pdf.text DateTime.parse(time).strftime('%d/%m/%Y %H:%M:%S')
          access_key = data[:access_key][4..48]
          barcode_1 = access_key[0..21]
          barcode_2 = access_key[22..44]
          blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_1)).to_png
          File.open('barcode1.png', 'wb'){|f| f.write blob }
          blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_2)).to_png
          File.open('barcode2.png', 'wb'){|f| f.write blob }
          pdf.image 'barcode1.png'
          pdf.image 'barcode2.png'
          pdf.text 'qrcode'
        end
      end
    end
  end
end
