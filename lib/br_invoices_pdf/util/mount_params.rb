# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module MountParams
      module_function

      def mount(xml, params)
        params.reduce({}) do |response, (param, path)|
          { **response, param => locate_element(xml, path) }
        end
      end
    end
  end
end
