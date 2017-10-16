# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    describe Parser do
      describe '.parse' do
        subject { described_class.parse(xml) }
        let(:xml) { double('xml') }

        let(:company_response) { double('company_response') }
        let(:products_response) { double('products_response') }
        let(:payments_response) { double('payments_response') }
        let(:customer_response) { double('customer_response') }
        let(:totals_response) { double('totals_response') }
        let(:taxes_response) { double('texes_response') }
        let(:emission_details_response) { double('emission_details_response') }

        let(:expectation) do
          {
            company: company_response,
            products: products_response,
            payments: payments_response,
            customer: customer_response,
            totals: totals_response,
            taxes: taxes_response,
            emission_details: emission_details_response
          }
        end

        it do
          expect(Parser::Company).to receive(:execute).with(xml).and_return(company_response)
          expect(Parser::Products).to receive(:execute).with(xml).and_return(products_response)
          expect(Parser::Payments).to receive(:execute).with(xml).and_return(payments_response)
          expect(Parser::Customer).to receive(:execute).with(xml).and_return(customer_response)
          expect(Parser::Totals).to receive(:execute).with(xml).and_return(totals_response)
          expect(Parser::Taxes).to receive(:execute).with(xml).and_return(taxes_response)
          expect(Parser::EmissionDetails).to receive(:execute).with(xml).and_return(emission_details_response)
          expect(subject).to eq(expectation)
        end
      end
    end
  end
end
