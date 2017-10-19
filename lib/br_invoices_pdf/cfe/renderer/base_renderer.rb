# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    module Renderer
      module BaseRenderer
        extend Util::BaseRenderer

        module_function

        ADDRESS_FORMAT = '%s, %s, %s, %s, %s/%s'
        def format_address(address)
          ADDRESS_FORMAT % %i(public_place number complement neighborhood city state).map(&address.method(:[]))
        end
      end
    end
  end
end
