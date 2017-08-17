module BrInvoicesPdf
  module Cfe
    module Renderer
      module Totals
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          insert_box_info(pdf, data) 

          pdf.move_down(5)
        end

        def insert_box_info(pdf, data, xpos= 0)
          third_width = page_content_width(pdf) * 0.333333333
          ypos = pdf.cursor
          box_info(data[:payment]).each do |(title, value)|
            insert_box(pdf, title: title, value: value, xpos: xpos, ypos: ypos, third_width: third_width)
            xpos += third_width
          end
        end

        def insert_box(pdf, params)
          box(pdf, [params[:xpos], params[:ypos]], params[:third_width]) do
            insert_texts(pdf, params[:title], params[:value])
          end
        end

        def insert_texts(pdf, title, value)
          pdf.text(title, style: :italic)
          pdf.text(value, align: :right)
        end
        private_class_method :insert_texts

        def box_info(data_payment)
          [
            ['Total bruto dos itens', format_currency(BigDecimal(data_payment[:total_price]))],
            ['Desconto', format_currency(BigDecimal(data_payment[:discount]))],
            ['Total', format_currency(BigDecimal(data_payment[:total]))]
          ]
        end
        private_class_method :box_info
      end
    end
  end
end
