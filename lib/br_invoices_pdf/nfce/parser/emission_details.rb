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
            **contingency_params(xml),
            qrcode_url: xml.locate('NFe/infNFeSupl/qrCode').first.nodes.first.value,
            receival_timestamp: locate_element_to_date(xml, 'protNFe/infProt/dhRecbto'),
            access_key: locate_element(xml, 'protNFe/infProt/chNFe'),
            authorization_protocol: locate_element(xml, 'protNFe/infProt/nProt')
          }
        end

        def contingency_params(xml)
          emission_path = emission_root_path(xml)

          hash = {
            type: EMISSION_TYPES[(locate_element(xml, "#{emission_path}/tpEmis") || '1').to_sym],
            number: locate_element(xml, "#{emission_path}/nNF"),
            serie: locate_element(xml, "#{emission_path}/serie"),
            emission_timestamp: locate_element_to_date(xml, "#{emission_path}/dhEmi"),
            check_url: check_url(xml)
          }

          node = xml.locate('infNFeSupl/qrCode').first

          hash[:qrcode_url] = node.nodes.first.value if node
          hash
        end

        def check_url(xml)
          emission_path = emission_root_path(xml)

          check_urls = Util::NfceCheckUrls::URLS[locate_element(xml, "#{emission_path}/cUF").to_sym]
          check_urls[locate_element(xml, "#{emission_path}/tpAmb").to_sym]
        end
        private_class_method :check_url

        def locate_element_to_date(xml, path)
          element = locate_element(xml, path)

          Time.parse(element).utc
        rescue StandardError => _e
          Time.parse("#{element[0..18]}-03:00").utc
        end
        private_class_method :locate_element_to_date
      end
    end
  end
end
