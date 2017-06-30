require 'spec_helper'

describe BrInvoicesPdf do
  it 'has a version number' do
    expect(BrInvoicesPdf::VERSION).not_to be nil
  end

  before do
    # Clean registered generators
    BrInvoicesPdf.instance_variable_set(:@generators, {})
  end

  describe '.register' do
    subject { BrInvoicesPdf.register(type, renderer, parser) }

    let(:type) { :foobar }
    let(:renderer) { double('renderer') }
    let(:parser) { double('parser') }

    it 'adds a new generator to the list' do
      expect { subject }.to change { BrInvoicesPdf.supported_document_types }.from([]).to([:foobar])
    end

    context 'when type is a string' do
      let(:type) { 'str_foobar' }

      it 'adds a new generator converting the type to Symbol' do
        expect { subject }.to change { BrInvoicesPdf.supported_document_types }.from([]).to([:str_foobar])
      end
    end

    context 'when type is not a String or Symbol' do
      let(:type) { Object.new }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '.supported_document_types' do
    subject { described_class.supported_document_types }

    context 'when there is no generator registered' do
      it { is_expected.to be_empty }
    end

    context 'when there is any generator registered' do
      before do
        BrInvoicesPdf.register(:foo, double('renderer'), double('parser'))
        BrInvoicesPdf.register('bar', double('renderer'), double('parser'))
      end

      it { is_expected.to_not be_empty }
      it { is_expected.to eq([:foo, :bar]) }
    end
  end
end
