require 'br_invoices_pdf/version'

module BrInvoicesPdf
  def self.generate(xml_path, pdf_path, options)
    case options[:document_type].to_sym
    when :cfe
      Cfe.new(xml_path, pdf_path).save
    end
  end
end
