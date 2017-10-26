# frozen_string_literal: true

describe BrInvoicesPdf::Util::MountParams do
  let(:xml) { Ox.dump(foo: 'bar') }

  def locate_element_mock(path, value)
    allow(described_class).to receive(:locate_element)
      .with(xml, path).and_return(value)
  end

  describe '.mount' do
    subject { described_class.mount(xml, params) }

    before do
      locate_element_mock(params[:foo], value)
    end

    let(:params) { { foo: 'root/some' } }
    let(:value) { 'some value' }

    it { expect(subject).to eql(params.keys.first => value) }
  end
end
