# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module BaseRenderer
      module_function

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

      # :reek:FeatureEnvy
      def pdf_setup(pdf)
        pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do
          pdf.pad(10) do
            pdf.indent(10, 10) do
              yield
            end
          end
          pdf.stroke_bounds
        end
      end

      PRODUCT_TABLE_BASE_DATA = [['CÓD.', 'DESCRIÇÃO', 'QTD.', 'UND.', 'V.UNIT', 'V.TOT']].freeze
      # :reek:FeatureEnvy
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
      private_class_method :product_table_data

      CNPJ_FORMAT = '%02d.%03d.%03d/%04d-%02d'
      # :reek:FeatureEnvy
      def format_cnpj(cnpj)
        format(CNPJ_FORMAT, cnpj[0, 2].to_i, cnpj[2, 3].to_i, cnpj[5, 3].to_i,
               cnpj[8, 4].to_i, cnpj[12, 2].to_i)
      end

      CPF_FORMAT = '%d.%d.%d-%d'
      # :reek:FeatureEnvy
      def format_cpf(cpf)
        format(CPF_FORMAT, cpf[0, 3], cpf[3, 3], cpf[6, 3], cpf[9, 2])
      end

      # :reek:FeatureEnvy
      def format_currency(number_string)
        number = BigDecimal(number_string)
        format('%.2f', number.truncate(2)).tr('.', ',')
      end

      # :reek:FeatureEnvy
      def format_number(number_string, prec: 4)
        number = BigDecimal(number_string)
        format("%.#{prec}f", number.truncate(prec)).tr('.', ',')
      end

      # :reek:FeatureEnvy
      def page_paper_width(name)
        (name.is_a?(Array) ? name : PDF::Core::PageGeometry::SIZES[name]).first
      end

      # :reek:FeatureEnvy
      def page_content_width(pdf)
        page = pdf.page
        margins = page.margins
        page_paper_width(page.size) - margins[:left] - margins[:right]
      end
    end
  end
end
