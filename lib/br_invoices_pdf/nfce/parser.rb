module BrInvoicesPdf
  module Nfce
    module Parser
      module_function

      def parse(_xml)
        {
          company: {
            name: 'Visual Software LTDA',
            cnpj: '04717891000152',
            state_number: '19046011101',
            address: {
              streetname: 'Rua QSE 10',
              number: '15',
              district: 'Taguatinga Sul',
              city: 'Brasília',
              state: 'DF'
            }
          },
          products: [
            {
              code: "ADAP8209",
              description: 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL',
              quantity: BigDecimal('1'),
              unit_label: 'UN',
              unit_value: BigDecimal('9.3829'),
              total_value: BigDecimal('9.38')
            },
            {
              code: "3860",
              description: "ADAPTADOR DE CHIP SIM CARD",
              quantity: BigDecimal('1'),
              unit_label: 'UN',
              unit_value: BigDecimal('29.90'),
              total_value: BigDecimal('29.90')
            }
          ],
          payments: [
            { type: 'Dinheiro', amount: BigDecimal('9.38') }
          ],
          customer: {
            identification_type: 'CPF',
            identification: '111.111.111-11',
            address: {
              streetname: 'Rua QSE 10',
              number: '15',
              district: 'Taguatinga Sul',
              city: 'Brasília',
              state: 'DF'
            }
          },
          totals: {
            items: BigDecimal('1'),
            value: BigDecimal('9.38'),
            discounts: BigDecimal('0.00'),
          },
          taxes: {
            amount: BigDecimal('2.88'),
            percent: '30,69%',
            source: 'IBPT'
          },
          emission_details: {
            type: 'EMISSÃO NORMAL',
            number: 244,
            serie: 1,
            timestamp: Time.now,
            check_url: 'http://www.sefaz.mt.gov.br/nfce/consultanfce',
            access_key: '43219205556511011250530010000040772070548065',
            qrcode_url: 'http://www.sefaz.mt.gov.br/nfce/consultanfce',
            authorization_protocol: '14121300000006502 10',
          }
        }
      end
    end
  end
end
