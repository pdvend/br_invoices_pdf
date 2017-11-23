# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module EmissionDetails
        extend Util::XmlLocate

        module_function

        def emission_root_path(xml)
          "#{root_path(xml)}/ide"
        end

        EMISSION_TYPES = {
          '1': 'Emissão normal',
          '2': 'Contingência FS-IA',
          '3': 'Contingência SCAN',
          '4': 'Contingência DPEC',
          '5': 'Contingência FS-DA, com impressão do DANFE em formulário de segurança',
          '6': 'Contingência SVC-AN',
          '7': 'Contingência SVC-RS',
          '9': 'Contingência off-line da NFC-e'
        }.freeze

        def execute(xml)
          locate_element(xml, 'protNFe/infProt/chNFe') ? normal_params(xml) : contingency_params(xml)
        end

        def normal_params(xml)
          {
            type: EMISSION_TYPES[locate_element(xml, "#{emission_root_path(xml)}/tpEmis").to_sym],
            number: locate_element(xml, "#{emission_root_path(xml)}/nNF"),
            serie: locate_element(xml, "#{emission_root_path(xml)}/serie"),
            emission_timestamp: locate_element_to_date(xml, "#{emission_root_path(xml)}/dhEmi"),
            receival_timestamp: locate_element_to_date(xml, 'protNFe/infProt/dhRecbto'),
            check_url: check_url(xml),
            access_key: locate_element(xml, 'protNFe/infProt/chNFe'),
            qrcode_url: xml.locate('NFe/infNFeSupl/qrCode').first.nodes.first.value,
            authorization_protocol: locate_element(xml, 'protNFe/infProt/nProt')
          }
        end

        def contingency_params(xml)
          {
            type: EMISSION_TYPES[locate_element(xml, "#{emission_root_path(xml)}/tpEmis").to_sym],
            number: locate_element(xml, "#{emission_root_path(xml)}/nNF"),
            serie: locate_element(xml, "#{emission_root_path(xml)}/serie"),
            emission_timestamp: locate_element_to_date(xml, "#{emission_root_path(xml)}/dhEmi"),
            check_url: check_url(xml),
            qrcode_url: xml.locate('infNFeSupl/qrCode').first.nodes.first.value
          }
        end

        def check_url(xml)
          check_urls = Util::NfceCheckUrls::URLS[locate_element(xml, "#{emission_root_path(xml)}/cUF").to_sym]
          check_urls[locate_element(xml, "#{emission_root_path(xml)}/tpAmb").to_sym]
        end
        private_class_method :check_url

        def locate_element_to_date(xml, path)
          Time.parse(locate_element(xml, path)).utc
        end
        private_class_method :locate_element_to_date
      end
    end
  end
end
