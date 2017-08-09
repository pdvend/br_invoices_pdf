module BrInvoicesPdf
  module Cfe
    module Renderer
      module_function

      SAT_QRCODE_SEPARATOR   = '|'.freeze
      AUTO_HEIGHT_MOCK = 2000

      def pdf(data, options)
        page_width = page_paper_width(options[:page_size])

        Prawn::Document.new(options.merge(page_size: [page_width, AUTO_HEIGHT_MOCK])) do |pdf|
          pdf.font_size(7) do
            add_company_identification(pdf, data)
            add_header(pdf, data)
            add_product_table(pdf, data)
            add_totals(pdf, data)
            add_payment_forms(pdf, data)
            add_fisco_info(pdf, data)
            add_taxes_info(pdf, data)
            add_qrcode(pdf, data)

            pdf.page.dictionary.data[:MediaBox] = [0, pdf.y - pdf.page.margins[:bottom], page_width, AUTO_HEIGHT_MOCK]
          end
        end
      end

      def add_qrcode(pdf, data)
        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          pdf.text("QR Code\n\n", style: :italic)

          page_width = page_paper_width(pdf.page.size)
          qrcode_size = page_width * 0.65

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

          options = {
            at: [(page_width - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: qrcode_size
          }

          pdf.image(data, options)
        end
      end

      def add_taxes_info(pdf, data)
        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          pdf.text("Tributos\n\n", style: :italic)
          value = format_currency(BigDecimal(data[:payment][:approximate_value_of_taxex]))
          text = "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ #{value}\n\n"
          pdf.text(text, align: :center)
          pdf.text('SAT Número ' + data[:sat_params][:sat_number], align: :center)
          time = data[:sat_params][:emission_date] + data[:sat_params][:emission_hour]
          pdf.text(DateTime.parse(time).strftime('%d/%m/%Y %H:%M:%S'), align: :center)
        end
      end

      def add_fisco_info(pdf, data)
        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |box|
          pdf.pad(10) do
            pdf.indent(10, 10) do
              pdf.text("Observações do fisco\n\n", style: :italic)

              data[:fisco_obs].each do |element|
                pdf.text(element[:field] + ': ' + element[:text], align: :center)
              end
            end
          end

          pdf.stroke_bounds
        end
      end

      def add_payment_forms(pdf, data)
        width = page_content_width(pdf)
        table_data = payments_table_data(data, width)

        pdf.font_size(6) do
          pdf.table(table_data, width: width) do |table|
            table.columns([0,1]).valign = :center
            table.columns(1).align = :right
            table.row([0, table_data.size - 1]).font_style = :bold
            table.row([0, table_data.size - 2]).font_style = :bold
          end
        end

        pdf.move_down(5)
      end

      def add_totals(pdf, data)
        xpos = 0
        ypos = pdf.cursor
        third_width = page_content_width(pdf) * 0.333333333
        [
          ["Total bruto dos itens", format_currency(BigDecimal(data[:payment][:total_price]))],
          ["Desconto", format_currency(BigDecimal(data[:payment][:discount]))],
          ["Total", format_currency(BigDecimal(data[:payment][:total]))]
        ].each do |(title, value)|
          box(pdf, [xpos, ypos], third_width) do
            pdf.text(title, style: :italic)
            pdf.text(value, align: :right)
          end

          xpos += third_width
        end

        pdf.move_down(5)
      end

      def add_product_table(pdf, data)
        width = page_content_width(pdf)
        table_data = product_table_data(data)

        pdf.font_size(6) do
          pdf.table(table_data, width: width) do |table|
            table.row(0).font_style = :bold
            table.row(0).align = :center

            table.columns(0..5).valign = :center
            table.columns([2,4,5]).align = :right
            table.column(3).align = :center

            table.column(0).width = table.width * 0.16
            table.column(2).width = table.width * 0.13
            table.column(3).width = table.width * 0.13
            table.column(4).width = table.width * 0.135
            table.column(5).width = table.width * 0.135
          end
        end

        pdf.move_down(5)
      end

      def add_header(pdf, data)
        cpf = data[:cpf] ? 'CONSUMIDOR:' + data[:cpf] : 'CONSUMIDOR NAO IDENTIFICADO'

        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |box|
          pdf.pad(10) do
            pdf.indent(10, 10) do
              pdf.font("Helvetica", style: :bold)
              pdf.text("Extrato: #{data[:document_number]}", align: :center)
              pdf.text(cpf, align: :center)
              pdf.text("CUPOM FISCAL ELETRONICO - SAT", align: :center)
              pdf.font("Helvetica", style: :normal, align: :center)
            end
          end

          pdf.stroke_bounds
        end

        pdf.move_down(5)
      end

      PRODUCT_TABLE_BASE_DATA = [['CÓD.', 'DESCRIÇÃO', 'QTD.', 'UND.', 'V.UNIT', 'V.TOT']].freeze
      def product_table_data(data)
        data[:products].reduce(PRODUCT_TABLE_BASE_DATA) do |result, cur|
          result + [[
            cur[:code],
            cur[:description],
            format_number(BigDecimal(cur[:quantity])),
            cur[:unit_label],
            format_currency(BigDecimal(cur[:unit_value])),
            format_currency(BigDecimal(cur[:total_value]))
          ]]
        end
      end

      def format_currency(num)
        num.truncate.to_s.reverse.split(/.../).join('.').reverse + (',%02d' % (num.frac * 100).truncate)
      end

      def format_number(num, prec: 4)
        num.truncate.to_s + (prec > 0 ? (",%0#{prec}d" % (num.frac * 10 ** prec).truncate) : "")
      end

      def page_paper_width(name)
        (name.is_a?(Array) ? name : PDF::Core::PageGeometry::SIZES[name]).first
      end

      def page_content_width(pdf)
        margins = pdf.page.margins
        page_paper_width(pdf.page.size) - margins[:left] - margins[:right]
      end

      def add_company_identification(pdf, data)
        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |box|
          pdf.pad(10) do
            pdf.indent(10, 10) do
              pdf.text(data[:company_attributes][:company_name], align: :center)
              pdf.text(data[:company_attributes][:trading_name], align: :center)

              pdf.text("CNPJ: " + format_cnpj(data[:company_attributes][:cnpj]), align: :center)
              pdf.text("Inscrição Estadual: " + data[:company_attributes][:ie], align: :center)
              pdf.text(format_address(data[:company_attributes][:address]), align: :center)
            end
          end

          pdf.stroke_bounds
        end
      end

      def box(pdf, position, width)
        pdf.bounding_box(position, width: width) do
          pdf.pad(2) do
            pdf.indent(2, 2) do
              yield
            end
          end

          pdf.stroke_bounds
        end
      end

      CNPJ_FORMAT = "%d.%d.%d/%d-%d"
      def format_cnpj(cnpj)
        CNPJ_FORMAT % [cnpj[0,2], cnpj[2,3], cnpj[5,3], cnpj[8,4], cnpj[12,2]]
      end

      PAYMENTS_TABLE_BASE_DATA = [['FORMA DE PAGAMENTO', 'VALOR']].freeze
      def payments_table_data(data, width)
        payments_data = data[:payments].reduce(PAYMENTS_TABLE_BASE_DATA) do |result, cur|
          result + [[cur[:type], format_currency(BigDecimal(cur[:amount]))]]
        end

        payments_data.push(["TROCO", format_currency(BigDecimal(data[:payment][:cash_back]))])
        payments_data.push(["TOTAL", format_currency(BigDecimal(data[:payment][:payd]))])

        payments_data
      end

      ADDRESS_FORMAT = "%s, %s, %s, %s, %s/%s"
      def format_address(address)
        ADDRESS_FORMAT % [:public_place, :number, :complement, :neighborhood, :city, :state].map(&address.method(:[]))
      end
    end
  end
end
