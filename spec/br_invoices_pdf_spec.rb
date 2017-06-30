require 'spec_helper'

describe BrInvoicesPdf do
  it 'has a version number' do
    expect(BrInvoicesPdf::VERSION).not_to be nil
  end

  before do
    # Clean registered generators
    BrInvoicesPdf.instance_variable_set(:@generators, {})
  end

  describe '.generate' do
    subject { BrInvoicesPdf.generate(type, xml, options) }

    let(:generator) { double('generator') }
    let(:type) { :test }
    let(:xml) { Ox.dump(foo: :bar) }
    let(:options) { {} }

    before do
      # Fill generators with some fake generator
      BrInvoicesPdf.instance_variable_set(:@generators, test: generator)
    end

    it 'passes xml and options to generator' do
      expect(generator).to receive(:generate).with(xml, options)
      subject
    end

    context 'when type is unknown' do
      let(:type) { :foo }
      let(:expected_message) { '`:foo` is not supported. Must be one of [:test]' }

      it { expect { subject }.to raise_error(BrInvoicesPdf::Errors::InvalidDocumentType, expected_message) }
    end
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
      it { is_expected.to eq(%i[foo bar]) }
    end
  end
end
