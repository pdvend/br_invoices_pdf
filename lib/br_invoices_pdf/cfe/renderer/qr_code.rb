module BrInvoicesPdf
  module Cfe
    module Renderer
      module QrCode
        extend BaseRenderer

        module_function

        SAT_QRCODE_SEPARATOR = '|'.freeze
        BARCODE_HEIGHT = 50

        def execute(pdf, data)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text("Códigos de barra e QR Code\n\n", style: :italic)

            page_width = page_paper_width(pdf.page.size)
            qrcode_size = page_width * 0.65
            access_key = data[:access_key][4..48]

            generate_bar_codes(pdf, access_key, page_width, qrcode_size)
            generate_qr_code(pdf, access_key, data, qrcode_size, page_width)

            pdf.move_down(10)
          end
        end

        def generate_qr_code(pdf, access_key, data, qrcode_size, page_width)
          qrcode_string = generate_qr_code_string(access_key, data)

          pdf.indent((page_width - qrcode_size) / 2, 10) do
            pdf.image(generate_qr_code_data(qrcode_string, qrcode_size))
          end
        end

        def generate_qr_code_data(qr_code_string, qrcode_size)
          qrcode = RQRCode::QRCode.new(qr_code_string)
          blob = qrcode.as_png(size: qrcode_size.to_i, border_modules: 0).to_blob
          StringIO.new(blob)
        end

        # rubocop:disable Metrics/AbcSize
        def generate_qr_code_string(access_key, data)
          access_key + SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_date] +
            SAT_QRCODE_SEPARATOR + data[:sat_params][:emission_hour] +
            SAT_QRCODE_SEPARATOR + data[:payment][:total].delete('.') + SAT_QRCODE_SEPARATOR +
            data[:company_attributes][:cnpj] + SAT_QRCODE_SEPARATOR +
            data[:sat_params][:document_qr_code_signature]
        end

        def generate_bar_codes(pdf, access_key, page_width, qrcode_size)
          pdf.image(generate_barcode_one(access_key), barcode_options(pdf, page_width, qrcode_size))
          pdf.move_down(55)
          pdf.image(generate_barcode_two(access_key), barcode_options(pdf, page_width, qrcode_size))
          pdf.move_down(55)
        end

        def generate_barcode_one(access_key)
          key = access_key[0..21]
          blob = Barby::PngOutputter.new(Barby::Code39.new(key)).to_png
          StringIO.new(blob)
        end

        def generate_barcode_two(access_key)
          key = access_key[22..44]
          blob = Barby::PngOutputter.new(Barby::Code39.new(key)).to_png
          StringIO.new(blob)
        end

        def barcode_options(pdf, page_width, qrcode_size)
          {
            at: [(page_width - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: BARCODE_HEIGHT
          }
        end
      end
    end
  end
end
