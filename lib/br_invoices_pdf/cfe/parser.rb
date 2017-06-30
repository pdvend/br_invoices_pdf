module BrInvoicesPdf
  module Cfe
    module Parser
      module_function

      # atributos
      # company_name -> emit,xNome
      # trading_name -> emit,xFant
      # company_address -> emit,enderEmit
      # city -> emit,enderEmit
      # company_state -> ?
      # company_zipcode -> emit,enderEmit,CEP
      # cnpj -> ide,Cnpj
      # IE (numero do estado) -> emit,IE
      # cfe_number -> ide,NFCE
      # cpf -> ide,NFCE

      def parse(_xml)
        # Retornar uma hash com todos os atributos necessarios
        {

        }
      end
    end
  end
end
