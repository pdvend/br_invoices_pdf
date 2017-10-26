# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Renderer
      module BaseRenderer
        extend Util::BaseRenderer

        module_function

        ADDRESS_FORMAT = '%s, %s, %s, %s/%s'
        def format_address(address)
          ADDRESS_FORMAT % %i(streetname number district city state).map(&address.method(:[]))
        end

        def format_date(date)
          date.strftime('%H:%M:%S %d/%m/%Y')
        end
      end
    end
  end
end
