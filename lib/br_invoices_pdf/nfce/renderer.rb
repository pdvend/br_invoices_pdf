# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    class Renderer
      AUTO_HEIGHT_MOCK = 2000

      def pdf(data, options)
        page_width = page_paper_width(options[:page_size])

        Prawn::Document.new(options.merge(page_size: [page_width, AUTO_HEIGHT_MOCK])) do |pdf|
          pdf.font_size(7) do
            add_company_identification(pdf, data)
            add_header(pdf)
            add_product_table(pdf, data)
            add_totals(pdf, data)
            add_payment_forms(pdf, data)
            add_taxes_info(pdf, data)
            add_emission_details(pdf, data)
            add_customer(pdf, data)
            add_qrcode(pdf, data)
            add_authorization_protocol(pdf, data)

            pdf.page.dictionary.data[:MediaBox] = [0, pdf.y - pdf.page.margins[:bottom], page_width, AUTO_HEIGHT_MOCK]
          end
        end
      end

      private

      def add_company_identification(pdf, data)
        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |_box|
          pdf.pad(10) do
            pdf.indent(50) do
              pdf.text(data[:company][:name])
              pdf.text('CNPJ: ' + format_cnpj(data[:company][:cnpj]))
              pdf.text('Inscrição Estadual: ' + data[:company][:state_number])
              pdf.text(format_address(data[:company][:address]))
            end
          end

          pdf.stroke_bounds
        end
      end

      def add_header(pdf)
        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do |_box|
          pdf.pad(10) do
            pdf.indent(10, 10) do
              pdf.font('Helvetica', style: :bold)
              pdf.text("DANFE NFC-e - Documento Auxiliar da Nota Fiscal Eletrônica para Consumidor Final\n\n", align: :center)
              pdf.font('Helvetica', style: :normal)
              pdf.text('Não permite aproveitamento de crédito de ICMS', align: :center)
            end
          end

          pdf.stroke_bounds
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
            table.columns([2, 4, 5]).align = :right
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

      def add_totals(pdf, data)
        xpos = 0
        ypos = pdf.cursor
        third_width = page_content_width(pdf) * 0.25
        totals = data[:totals]

        [
          ['Item(ns)', format_number(totals[:items])],
          ['Subtotal', format_currency(totals[:subtotal])],
          ['Desconto', format_currency(totals[:discounts])],
          ['Total', format_currency(totals[:total])]
        ].each do |(title, value)|
          box(pdf, [xpos, ypos], third_width) do
            pdf.text(title, style: :italic)
            pdf.text(value, align: :right)
          end

          xpos += third_width
        end

        pdf.move_down(5)
      end

      def add_payment_forms(pdf, data)
        width = page_content_width(pdf)
        table_data = payments_table_data(data, width)

        pdf.font_size(6) do
          pdf.table(table_data, width: width) do |table|
            table.columns([0, 1]).valign = :center
            table.columns(1).align = :right
            table.row([0, table_data.size - 1]).font_style = :bold
          end
        end

        pdf.move_down(5)
      end

      def add_taxes_info(pdf, data)
        taxes = data[:taxes]

        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          pdf.text("Tributos\n\n", style: :italic)
          value = format_currency(taxes[:amount])
          percent = taxes[:percent]
          text = "Informação dos tributos totais incidentes (Lei Federal 12.741/2012):\n R$ #{value} (#{percent})\n\n"
          pdf.text(text, align: :center)
        end
      end

      def add_emission_details(pdf, data)
        emission_details = data[:emission_details]

        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          number = emission_details[:number]
          serie = emission_details[:serie]
          timestamp = emission_details[:emission_timestamp].strftime('%H:%M:%S %d/%m/%Y')

          pdf.text("Mensagem Fiscal\n\n", style: :italic)
          pdf.text("Número: #{number} - Série: #{serie}", align: :center)
          pdf.text("\nEmissão: #{timestamp} - Via Consumidor", align: :center)
          pdf.text("\nConsulte pela Chave de Acesso em: #{emission_details[:check_url]}", align: :center)
          pdf.text("\nCHAVE DE ACESSO:\n#{format_access_key(emission_details[:access_key])}\n\n", align: :center)
        end
      end

      def add_customer(pdf, data)
        customer = data[:customer]

        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          pdf.text("Consumidor\n\n", style: :italic)

          if customer[:identification_type]
            pdf.text("#{customer[:identification_type]}: #{customer[:identification]}", align: :center)
          else
            pdf.text('CONSUMIDOR NÃO IDENTIFICADO', align: :center)
          end

          pdf.text("Endereço: #{format_address(customer[:address])}", align: :center) if customer[:address]
          pdf.text("\n")
        end
      end

      def add_qrcode(pdf, data)
        qrcode_url = data[:emission_details][:qrcode_url]

        page_width = page_paper_width(pdf.page.size)
        qrcode_size = page_width * 0.65

        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          pdf.text('Consulta via QRCode', style: :italic)

          options = {
            at: [(page_width - qrcode_size) / 2, pdf.cursor],
            width: qrcode_size,
            height: qrcode_size
          }

          qrcode = RQRCode::QRCode.new(qrcode_url)
          blob = qrcode.as_png(size: 220, border_modules: 0).to_blob
          data = StringIO.new(blob)
          pdf.image(data, options)

          pdf.move_down(qrcode_size)
        end
      end

      def add_authorization_protocol(pdf, data)
        emission_details = data[:emission_details]
        box(pdf, [0, pdf.cursor], page_content_width(pdf)) do
          text = "\nProtocolo de autorização: #{emission_details[:authorization_protocol]}"
          timestamp = emission_details[:receival_timestamp].strftime('%H:%M:%S %d/%m/%Y')
          pdf.text(text, align: :center)
          pdf.text("Data: #{timestamp}\n\n", align: :center)
        end
      end

      PRODUCT_TABLE_BASE_DATA = [['CÓD.', 'DESCRIÇÃO', 'QTD.', 'UND.', 'V.UNIT', 'V.TOT']].freeze
      def product_table_data(data)
        data[:products].reduce(PRODUCT_TABLE_BASE_DATA) do |result, cur|
          result + [[
            cur[:code],
            cur[:description],
            format_number(cur[:quantity]),
            cur[:unit_label],
            format_currency(cur[:unit_value]),
            format_currency(cur[:total_value])
          ]]
        end
      end

      PAYMENTS_TABLE_BASE_DATA = [['FORMA DE PAGAMENTO', 'VALOR']].freeze
      def payments_table_data(data, _width)
        payments_data = data[:payments].reduce(PAYMENTS_TABLE_BASE_DATA) do |result, cur|
          result + [[cur[:type], format_currency(cur[:amount])]]
        end
        payments_data.push(['TROCO', format_currency(data[:totals][:cashback])])
        payments_data
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

      CNPJ_FORMAT = '%d.%d.%d/%d-%d'
      def format_cnpj(cnpj)
        format(CNPJ_FORMAT, cnpj[0, 2], cnpj[2, 3], cnpj[5, 3], cnpj[8, 4], cnpj[12, 2])
      end

      ADDRESS_FORMAT = '%s, %s, %s, %s/%s'
      def format_address(address)
        ADDRESS_FORMAT % %i(streetname number district city state).map(&address.method(:[]))
      end

      def format_currency(number_string)
        number = BigDecimal(number_string)
        format('%.2f', number.truncate(2)).tr('.', ',')
      end

      # :reek:FeatureEnvy
      def format_number(number_string, prec: 4)
        number = BigDecimal(number_string)
        format("%.#{prec}f", number.truncate(prec)).tr('.', ',')
      end

      def format_access_key(key)
        key.scan(/..../).join(' ')
      end

      def page_content_width(pdf)
        margins = pdf.page.margins
        page_paper_width(pdf.page.size) - margins[:left] - margins[:right]
      end

      def page_paper_width(name)
        (name.is_a?(Array) ? name : PDF::Core::PageGeometry::SIZES[name]).first
      end
    end
  end
end
