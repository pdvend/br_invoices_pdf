module BrInvoicesPdf
  module Cfe
    module Renderer
      class QrCode
        include BaseRenderer

        SAT_QRCODE_SEPARATOR = '|'.freeze

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text("Códigos de barra e QR Code\n\n", style: :italic)

            page_width = page_paper_width(pdf.page.size)
            qrcode_size = page_width * 0.65
            barcode_height = 50

            access_key = data[:access_key][4..48]
            barcode_1 = access_key[0..21]
            barcode_2 = access_key[22..44]
            blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_1)).to_png
            barcode1 = StringIO.new(blob)
            blob = Barby::PngOutputter.new(Barby::Code39.new(barcode_2)).to_png
            barcode2 = StringIO.new(blob)

            barcode_options = {
              at: [(page_width - qrcode_size) / 2, pdf.cursor],
              width: qrcode_size,
              height: barcode_height
            }

            pdf.image(barcode1, barcode_options)
            pdf.move_down(55)
            pdf.image(barcode2, barcode_options)
            pdf.move_down(55)

            qr_code_string = access_key + SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_date] +
                             SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_hour] +
                             SAT_QRCODE_SEPARATOR + data[:payment][:total].delete('.') + SAT_QRCODE_SEPARATOR +
                             data[:company_attributes][:cnpj] + SAT_QRCODE_SEPARATOR +
                             data[:sat_params][:document_qr_code_signature]
            qrcode = RQRCode::QRCode.new(qr_code_string)
            blob = qrcode.as_png(size: qrcode_size.to_i, border_modules: 0).to_blob
            data = StringIO.new(blob)

            pdf.indent((page_width - qrcode_size) / 2, 10) do
              pdf.image(data)
            end

            pdf.move_down(10)
          end
        end
      end
    end
  end
end
