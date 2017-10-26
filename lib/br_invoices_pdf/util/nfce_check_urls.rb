# frozen_string_literal: true

module BrInvoicesPdf
  module Util
    module NfceCheckUrls
      URLS = {
       '12': {
               '1': 'http://www.sefaznet.ac.gov.br/nfce/consulta',
               '2': 'http://hml.sefaznet.ac.gov.br/nfce/consulta'
             },
       '27': {
               '1': 'http://nfce.sefaz.al.gov.br/consultaNFCe.htm',
               '2': 'http://nfce.sefaz.al.gov.br/consultaNFCe.htm'
             },
       '16': {
               '1': 'https://www.sefaz.ap.gov.br/sate/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1261',
               '2': 'https://www.sefaz.ap.gov.br/sate1/seg/SEGf_AcessarFuncao.jsp?cdFuncao=FIS_1261'
             },
       '13': {
               '1': 'http://sistemas.sefaz.am.gov.br/nfceweb/formConsulta.do',
               '2': 'http://homnfce.sefaz.am.gov.br/nfceweb/formConsulta.do'
             },
       '29': {
              '1': 'http://nfe.sefaz.ba.gov.br/servicos/nfce/default.aspx',
              '2': 'http://hnfe.sefaz.ba.gov.br/servicos/nfce/default.aspx'
             },
       '23': {
              '1': 'http://nfceh.sefaz.ce.gov.br/pages/consultaNota.jsf',
              '2': 'http://nfceh.sefaz.ce.gov.br/pages/consultaNota.jsf'
             },
       '53': {
              '1': 'http://dec.fazenda.df.gov.br/NFCE/',
              '2': 'http://dec.fazenda.df.gov.br/NFCE/'
             },
       '32': {
              '1': 'http://app.sefaz.es.gov.br/ConsultaNFCe',
              '2': 'http://homologacao.sefaz.es.gov.br/ConsultaNFCe'
             },
       '21': {
              '1': 'http://www.nfce.sefaz.ma.gov.br/portal/consultaNFe.do?method=preFilterCupom&',
              '2': 'http://www.hom.nfce.sefaz.ma.gov.br/portal/consultarNFCe.jsp'
             },
       '51': {
              '1': 'http://www.sefaz.mt.gov.br/nfce/consultanfce',
              '2': 'http://homologacao.sefaz.mt.gov.br/nfce/consultanfce'
             },
       '50': {
              '1': 'http://www.dfe.ms.gov.br/nfce',
              '2': 'http://www.dfe.ms.gov.br/nfce'
             },
       '15': {
              '1': 'https://appnfc.sefa.pa.gov.br/portal/view/consultas/nfce/consultanfce.seam',
              '2': 'https://appnfc.sefa.pa.gov.br/portal-homologacao/view/consultas/nfce/consultanfce.seam'
             },
       '25': {
              '1': 'http://www.receita.pb.gov.br/nfce',
              '2': 'http://www.receita.pb.gov.br/nfcehom'
             },
       '41': {
              '1': 'http://www.fazenda.pr.gov.br/',
              '2': 'http://www.fazenda.pr.gov.br/'
             },
       '22': {
              '1': 'http://webas.sefaz.pi.gov.br/nfceweb/consultarNFCe.jsf',
              '2': 'http://webas.sefaz.pi.gov.br/nfceweb-homologacao/consultarNFCe.jsf'
             },
       '33': {
              '1': 'http://www.nfce.fazenda.rj.gov.br/consulta',
              '2': 'http://www.nfce.fazenda.rj.gov.br/consulta'
             },
       '24': {
              '1': 'http://nfce.set.rn.gov.br/consultarNFCe.aspx',
              '2': 'http://nfce.set.rn.gov.br/consultarNFCe.aspx'
             },
       '43': {
              '1': 'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx',
              '2': 'https://www.sefaz.rs.gov.br/NFCE/NFCE-COM.aspx'
             },
       '11': {
              '1': 'http://www.nfce.sefin.ro.gov.br/',
              '2': 'http://www.nfce.sefin.ro.gov.br/'
             },
       '14': {
              '1': 'https://www.sefaz.rr.gov.br/nfce/servlet/wp_consulta_nfce',
              '2': 'http://200.174.88.103:8080/nfce/servlet/wp_consulta_nfce'
             },
       '35': {
              '1': 'https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaPublica.aspx',
              '2': 'https://www.homologacao.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaPublica.aspx'
             },
       '28': {
              '1': 'http://www.nfce.se.gov.br/portal/portalNoticias.jsp',
              '2': 'http://www.hom.nfe.se.gov.br/portal/portalNoticias.jsp'
             },
       '17': {
              '1': 'http://apps.sefaz.to.gov.br/portal-nfce/consultarNFCe.jsf',
              '2': 'http://apps.sefaz.to.gov.br/portal-nfce-homologacao/consultarNFCe.jsf'
             }
      }.freeze
    end
  end
end
