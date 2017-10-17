# frozen_string_literal: true

module BrInvoicesPdf
  module Cfe
    describe Parser do
      describe '.parse' do
        subject { described_class.parse(xml) }
        let(:xml) { double('xml') }

        let(:sat_response) { 123 }
        let(:document_number_response) { 9999 }
        let(:payment_response) { double('payment') }
        let(:payments_response) { double('payments') }
        let(:products_data_response) { double('product_data') }
        let(:company_attributes_response) { double('company_attributes') }
        let(:fisco_obs_response) { double('fisco_obs') }
        let(:access_key_response) { double }
        let(:cpf_response) { '99999999999' }
        let(:cnpj_response) { '13054202000168' }
        let(:expectation) do
          {
            sat_params: sat_response,
            document_number: document_number_response,
            payment: payment_response,
            payments: payments_response,
            products: products_data_response,
            company_attributes: company_attributes_response,
            fisco_obs: fisco_obs_response,
            access_key: access_key_response,
            cpf: cpf_response,
            cnpj: cnpj_response
          }
        end
        it do
          expect(Parser::Sat).to receive(:execute).with(xml).and_return(sat_response)
          expect(Parser::DocumentNumber).to receive(:execute).with(xml).and_return(document_number_response)
          expect(Parser::Payment).to receive(:execute).with(xml).and_return(payment_response)
          expect(Parser::Payments).to receive(:execute).with(xml).and_return(payments_response)
          expect(Parser::ProductsData).to receive(:execute).with(xml).and_return(products_data_response)
          expect(Parser::CompanyAttributes).to receive(:execute).with(xml).and_return(company_attributes_response)
          expect(Parser::FiscoObs).to receive(:execute).with(xml).and_return(fisco_obs_response)
          expect(Parser::AccessKey).to receive(:execute).with(xml).and_return(access_key_response)
          expect(Parser::Cpf).to receive(:execute).with(xml).and_return(cpf_response)
          expect(Parser::Cnpj).to receive(:execute).with(xml).and_return(cnpj_response)
          expect(subject).to eq(expectation)
        end
      end
    end
  end
end
