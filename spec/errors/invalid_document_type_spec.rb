require 'spec_helper'

describe BrInvoicesPdf::Errors::InvalidDocumentType do
  describe '#initialize' do
    subject { described_class.new(type) }

    before do
      # Fill generators with some fake generator
      BrInvoicesPdf.instance_variable_set(:@generators, test: double('generator'))
    end

    let(:type) { :foo }

    it { expect { subject }.to_not raise_error }
    it { expect(subject.message).to eq('`:foo` is not supported. Must be one of [:test]') }
  end
end
