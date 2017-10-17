# frozen_string_literal: true

require 'br_invoices_pdf/nfce/parser'
require 'br_invoices_pdf/nfce/renderer/base_renderer'
require 'br_invoices_pdf/nfce/renderer'

module BrInvoicesPdf
  module Cfe
    BrInvoicesPdf.register(:nfce, Nfce::Renderer, Nfce::Parser)
  end
end
