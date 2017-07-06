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
            { type: 'Dinheiro', amount: BigDecimal('9.38') },
            { type: 'Outros', amount: BigDecimal('29.90') }
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
            items: BigDecimal('2'),
            subtotal: BigDecimal('9.38'),
            discounts: BigDecimal('0.00'),
            total: BigDecimal('39.28'),
            cashback: BigDecimal('0.00')
          },
          taxes: {
            amount: BigDecimal('2.88'),
            percent: '7,33%'
          },
          emission_details: {
            type: 'EMISSÃO NORMAL',
            number: 244,
            serie: 1,
            emission_timestamp: Time.now,
            receival_timestamp: Time.now,
            check_url: 'http://www.sefaz.mt.gov.br/nfce/consultanfce',
            access_key: '43219205556511011250530010000040772070548065',
            qrcode_url: 'http://dec.fazenda.df.gov.br/ConsultarNFCe.aspx?chNFe=53170607682493000136650000000036491761250045&nVersao=100&tpAmb=1&dhEmi=323031372d30362d32375431343a31303a30382d30333a3030&vNF=158.00&vICMS=0.00&digVal=48692f583862704b6134476d2f683836724471675543752b4645303d&cIdToken=000001&cHashQRCode=58B20E22B292B10DED3995DD4F299EEAD0BE6F92',
            authorization_protocol: '1412130000000650210',
          }
        }
      end
    end
  end
end
