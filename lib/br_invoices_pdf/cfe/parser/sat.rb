module BrInvoicesPdf
  module Cfe
    module Parser
      module Sat
        extend BaseParser
        module_function

        AVAILABLE_UF = { '35' => 'São Paulo' }.freeze

        def execute(xml)
          {
            pdv_number: locate_element(xml, 'infCFe/ide/numeroCaixa'),
            ncfe_number: locate_element(xml, 'infCFe/ide/nCFe'),
            uf: AVAILABLE_UF[locate_element(xml, 'infCFe/ide/cUF')],
            sat_number: locate_element(xml, 'infCFe/ide/nserieSAT'),
            emission_date: locate_element(xml, 'infCFe/ide/dEmi'),
            emission_hour: locate_element(xml, 'infCFe/ide/hEmi'),
            document_qr_code_signature: locate_element(xml, 'infCFe/ide/assinaturaQRCODE')
          }
        end
      end
    end
  end
end
