module BrInvoicesPdf
  module Cfe
    module Renderer
      module QrCode
        extend BaseRenderer

        module_function

        SAT_QRCODE_SEPARATOR = '|'.freeze
        BARCODE_HEIGHT = 50

        def execute(pdf, data)
          render_box(pdf) do
            options = pdf_options(page_paper_width(pdf.page.size), data)

            generate_barcodes(pdf, options)
            generate_qr_code(pdf, data, options)
          end
        end

        # :reek:FeatureEnvy
        def render_box(pdf)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text("Códigos de barra e QR Code\n\n", style: :italic)
            yield
            pdf.move_down(10)
          end
        end
        private_class_method :render_box

        def pdf_options(page_width, data)
          qrcode_size = page_width * 0.65
          barcodes_size = page_width * 0.85
          access_key = data[:access_key][4..48]

          { access_key: access_key, barcodes_size: barcodes_size, qrcode_size: qrcode_size, page_width: page_width }
        end
        private_class_method :pdf_options

        # :reek:FeatureEnvy
        def generate_qr_code(pdf, data, options)
          qrcode_string = generate_qr_code_string(options[:access_key], data)
          qrcode_size = options[:qrcode_size]
          opts = {
            at: [(options[:page_width] - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: qrcode_size
          }
          insert_image(pdf, generate_qr_code_data(qrcode_string, qrcode_size), opts)
        end
        private_class_method :generate_qr_code

        def generate_qr_code_data(qr_code_string, qrcode_size)
          qrcode = RQRCode::QRCode.new(qr_code_string)
          blob = qrcode.as_png(size: qrcode_size, border_modules: 0).to_blob
          StringIO.new(blob)
        end
        private_class_method :generate_qr_code_data

        # rubocop:disable Metrics/AbcSize
        def generate_qr_code_string(access_key, data)
          sat_params = data[:sat_params]
          access_key + SAT_QRCODE_SEPARATOR + sat_params[:emission_date] +
            SAT_QRCODE_SEPARATOR + sat_params[:emission_hour] +
            SAT_QRCODE_SEPARATOR + data[:payment][:total].delete('.') + SAT_QRCODE_SEPARATOR +
            data[:company_attributes][:cnpj] + SAT_QRCODE_SEPARATOR +
            sat_params[:document_qr_code_signature]
        end
        private_class_method :generate_qr_code_string

        def generate_barcodes(pdf, pdf_options)
          options = barcode_options(pdf, pdf_options[:page_width], pdf_options[:barcodes_size])
          access_key = pdf_options[:access_key]
          insert_image(pdf, generate_barcode(access_key[0..21]), options)
          insert_image(pdf, generate_barcode(access_key[22..44]), options)
        end
        private_class_method :generate_barcodes

        def insert_image(pdf, image, options)
          pdf.image(image, options)
          pdf.move_down(options[:height])
        end
        private_class_method :insert_image

        def generate_barcode(key)
          blob = Barby::PngOutputter.new(Barby::Code128A.new(key)).to_png
          StringIO.new(blob)
        end
        private_class_method :generate_barcode

        def barcode_options(pdf, page_width, qrcode_size)
          {
            at: [(page_width - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: BARCODE_HEIGHT
          }
        end
        private_class_method :barcode_options
      end
    end
  end
end
