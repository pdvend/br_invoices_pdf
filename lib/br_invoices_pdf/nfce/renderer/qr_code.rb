# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module QrCode
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          render_box(pdf) do
            options = pdf_options(page_paper_width(pdf.page.size))

            generate_qr_code(pdf, data, options)
          end
        end

        # :reek:FeatureEnvy
        def render_box(pdf)
          box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
            pdf.text('QR Code', style: :italic)
            yield
          end
        end
        private_class_method :render_box

        def pdf_options(page_width)
          qrcode_size = page_width * 0.65

          { qrcode_size: qrcode_size, page_width: page_width }
        end
        private_class_method :pdf_options

        # :reek:FeatureEnvy
        def generate_qr_code(pdf, data, options)
          qrcode_size = options[:qrcode_size]
          opts = {
            at: [(options[:page_width] - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: qrcode_size
          }
          insert_image(pdf, generate_qr_code_data(data[:emission_details][:qrcode_url], qrcode_size), opts)
        end
        private_class_method :generate_qr_code

        def generate_qr_code_data(qr_code_string, qrcode_size)
          qrcode = RQRCode::QRCode.new(qr_code_string)
          blob = qrcode.as_png(size: qrcode_size.to_i, border_modules: 0).to_blob
          StringIO.new(blob)
        end
        private_class_method :generate_qr_code_data

        def insert_image(pdf, image, options)
          pdf.image(image, options)
          pdf.move_down(options[:height])
        end
        private_class_method :insert_image
      end
    end
  end
end
