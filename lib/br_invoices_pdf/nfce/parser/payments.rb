# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Payments
        extend Util::XmlLocate

        module_function

        def execute(xml)
          xml_version = xml.locate(root_path(xml).to_s)

          return payments_new_version(xml) if xml_version.any? && xml_version[0].attributes[:versao][0] == '4'

          payments_old_version(xml)
        end

        def payments_old_version(xml)
          node_payments = xml.locate("#{root_path(xml)}/pag")
          node_payments.map(&method(:payment_by))
        end

        def payments_new_version(xml)
          node_payments = xml.locate("#{root_path(xml)}/pag/detPag")
          cashback = cashback_for(xml)

          node_payments.map do |payment|
            payment_by(payment, cashback: cashback)
          end
        end

        def cashback_for(xml)
          locate_element(xml.locate("#{root_path(xml)}/pag")[0], 'vTroco')
        end

        def payment_by(element, cashback: nil)
          payment = locate_element(element, 'tPag')

          cashback_amount = cashback if payment == '01'

          {
            type: Util::Enum::PAYMENT_TYPES[payment],
            amount: locate_element(element, 'vPag'),
            cashback: cashback_amount || locate_element(element, 'vTroco')
          }
        end
        private_class_method :payment_by
      end
    end
  end
end
