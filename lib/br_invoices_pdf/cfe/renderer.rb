module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      SAT_QRCODE_SEPARATOR   = '|'.freeze
      def pdf(data, options)
        Prawn::Document.new(options) do |pdf|
          address = data[:company_attributes][:address][:public_place] + ' ' +
                    data[:company_attributes][:address][:number] + ' ' +
                    data[:company_attributes][:address][:complement] + ' '
                    data[:company_attributes][:address][:city] + ' ' +
                    data[:company_attributes][:address][:neighborhood] + ' '
                    data[:company_attributes][:address][:cep]

          company_info = data[:company_attributes][:company_name] + "\n" +
                         data[:company_attributes][:trading_name] + "\n" +
                         'CNPJ: ' + data[:company_attributes][:cnpj] + "\n" +
                         'IE: ' + data[:company_attributes][:ie] + "\n" +
                         'IM: ' + data[:company_attributes][:im] + "\n" + address
          cpf = data[:cpf] ? 'CONSUMIDOR:' + data[:cpf] : 'CONSUMIDOR NAO IDENTIFICADO'
          extra_info = "Extrato: #{data[:document_number]}" + "\n" + cpf + "\n" +
                       'CUPOM FISCAL ELETRONICO - SAT'
          pdf.table([[company_info], [extra_info]])
          #######################################3
          first_colum = ['Qtd. produtos', 'Unid. produto', 'Descricao produto', 'Valor item', 'Total item']
          table_data = [first_colum]
          data[:products].each do |product|
            row =  [product[:quantity].to_i, product[:unit_label], product[:description],
                    sprintf( "%0.02f", product[:unit_value]),
                    sprintf( "%0.02f", product[:total_value])]
            table_data << row
          end
          pdf.table(table_data)
          #######################################3

          total_sale_data = 'Total bruto de itens' + 'R$ ' + data[:payment][:total_price] + "\n" +
                            'TOTAL R$ ' + data[:payment][:total] + "\n" +
                            'PAGO R$ ' + data[:payment][:payd] + "\n" +
                            'TROCO R$ ' + data[:payment][:cash_back]

          pdf.table([[total_sale_data]])
          #######################################3
          pdf.text 'Observações do fisco:', align: :center
          data[:fisco_obs].each do |element|
            pdf.text element[:field] + ': ' + element[:text] , align: :center
          end
          pdf.text '-' * 111
          pdf.text 'Valor aproximado dos tribustos deste cupom', align: :center
          pdf.text 'R$: ' + data[:payment][:approximate_value_of_taxex], align: :center
          pdf.text 'Conforme lei federal 12.741/2012', align: :center
          pdf.text 'SAT Número ' + data[:sat_params][:sat_number], align: :center
          time = data[:sat_params][:emission_date] + data[:sat_params][:emission_hour]
          pdf.text DateTime.parse(time).strftime('%d/%m/%Y %H:%M:%S'), align: :center
          access_key = data[:access_key][4..48]
          barcode_1 = access_key[0..21]
          barcode_2 = access_key[22..44]
          blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_1)).to_png
          barcode1 = StringIO.new(blob)
          blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_2)).to_png
          barcode2 = StringIO.new(blob)
          pdf.image barcode1, position: :center
          pdf.image barcode2, position: :center
          qr_code_string  = access_key +  SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_date] +
                            SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_hour] +
                            SAT_QRCODE_SEPARATOR + data[:payment][:total].gsub('.', '') + SAT_QRCODE_SEPARATOR +
                            data[:company_attributes][:cnpj] + SAT_QRCODE_SEPARATOR +
                            data[:sat_params][:document_qr_code_signature]
          qrcode = RQRCode::QRCode.new(qr_code_string)
          blob = qrcode.as_png(size: 220, border_modules: 0).to_blob
          data = StringIO.new(blob)
          pdf.image data, position: :center
          pdf.table([[{image: data}]])
        end
      end
    end
  end
end
