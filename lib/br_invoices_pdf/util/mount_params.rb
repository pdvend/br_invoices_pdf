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

      def address_params(root_path, local)
        {
          streetname: "#{root_path}/ender#{local}/xLgr",
          number: "#{root_path}/ender#{local}/nro",
          district: "#{root_path}/ender#{local}/xBairro",
          city: "#{root_path}/ender#{local}/xMun",
          state: "#{root_path}/ender#{local}/UF"
        }.freeze
      end
      private_class_method :address_params
    end
  end
end
