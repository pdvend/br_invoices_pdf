# frozen_string_literal: true

require 'br_invoices_pdf/nfce/parser'
require 'br_invoices_pdf/nfce/renderer'

module BrInvoicesPdf
  module Nfce
    BrInvoicesPdf.register(:nfce, Nfce::Renderer.new, Nfce::Parser)
  end
end
