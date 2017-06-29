module BrInvoicesPdf
  class Cfe < BasePdf
    def build_pdf
      xml_params = CfeXmlParser.parser(xml)
      Prawn::Document.new(PDF_OPTIONS) do |pdf|
        ## constroi o pdf
        pdf.text xml_params[:text]
      end
    end

    def save_pdf
      pdf.render_file(path)
    end
  end
end
