require 'spec_helper'

describe BrInvoicesPdf do
  it 'has a version number' do
    expect(BrInvoicesPdf::VERSION).not_to be nil
  end

  describe '.supported_document_types' do
    subject { described_class.supported_document_types }

    before do
      # Clean registered generators
      BrInvoicesPdf.instance_variable_set(:@generators, {})
    end

    context 'when there is no generator registered' do
      it { is_expected.to be_empty }
    end

    context 'when there is any generator registered' do
      before do
        BrInvoicesPdf.register(:foo, double('renderer'), double('parser'))
        BrInvoicesPdf.register(:bar, double('renderer'), double('parser'))
      end

      it { is_expected.to_not be_empty }
      it { is_expected.to eq([:foo, :bar]) }
    end

    context 'when there is a generator registered as string' do
      before do
        BrInvoicesPdf.register('bar', double('renderer'), double('parser'))
      end

      it { is_expected.to_not be_empty }
      it { is_expected.to include(:bar) }
    end
  end
end
