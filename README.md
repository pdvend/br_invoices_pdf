# BR Invoices PDF
[![Build Status](https://semaphoreci.com/api/v1/pdvend/br_invoices_pdf/branches/master/shields_badge.svg)](https://semaphoreci.com/pdvend/br_invoices_pdf)
[![Coverage Status](https://coveralls.io/repos/github/pdvend/br_invoices_pdf/badge.svg?branch=master)](https://coveralls.io/github/pdvend/br_invoices_pdf?branch=master)
[![Gem Version](https://badge.fury.io/rb/br_invoices_pdf.svg)](https://badge.fury.io/rb/br_invoices_pdf)
[![Dependency Status](https://gemnasium.com/badges/github.com/pdvend/br_invoices_pdf.svg)](https://gemnasium.com/github.com/pdvend/br_invoices_pdf)
[![Code Climate](https://codeclimate.com/github/pdvend/br_invoices_pdf/badges/gpa.svg)](https://codeclimate.com/github/pdvend/br_invoices_pdf)

Este projeto gera arquivos PDF para documentos fiscais no Brasil a partir de seus XMLs, suportando atualmente:
- NFC-e
- CF-e/SAT

## Instalação

Adicione esta linha ao `Gemfile` da sua aplicação:

```ruby
gem 'br_invoices_pdf'
```

Então execute:
```bash
bundle
```

## Utilização

- xml = File.binread('file.xml') # String do XML
- pdf = BrInvoicesPdf.generate(:nfce, xml, page_size: 'A7', margin: 1) # Gera o PDF
- File.binwrite('pdf_name.pdf', pdf) # Salva um arquivo

## Desenvolvendo

- Faça checkout neste repositório
- Rode `bin/setup` para instalar as dependências
- Você também pode rodar `bin/console` para um console interativo que te permitirá realizar testes
- Para instalar esta gem na sua máquina local, rode `bundle exec rake install`.
- Para realizar a release de uma nova versão, atualize o número no arquivo `lib/version.rb`, atualize o [CHANGELOG.md](/CHANGELOG.md)

## Contribuindo

Bugs reports e pull requests são bem vindos no GitHub em https://github.com/pdvend/br_invoices_pdf. Este projeto pretende ser um espaço seguro e acolhedor para a colaboração, e os contribuintes devem aderir ao código de conduta [Covenant Covenant](http://contributor-covenant.org).

