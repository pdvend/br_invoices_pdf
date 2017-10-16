describe BrInvoicesPdf::Nfce::Renderer::BaseRenderer do
  describe '.format_address' do
    subject { described_class.format_address(address) }
    let(:address) do
      {
        streetname: streetname,
        number: number,
        city: city,
        district: district,
        cep: cep,
        state: state
      }
    end
    let(:streetname) { 'SOME PLACE' }
    let(:number) { '99' }
    let(:city) { 'SOME CITY' }
    let(:district) { 'SOME NEIGHBORHOOD' }
    let(:cep) { '999999-999' }
    let(:state) { 'SS' }
    let(:expectation) { "#{streetname}, #{number}, #{district}, #{city}/#{state}" }

    it { expect(subject).to eq(expectation) }
  end

  describe '.box' do
    subject { described_class.box(pdf, position, width) { ; } }
    let(:pdf) { double('pdf') }
    let(:position) { 10 }
    let(:width) { 100 }

    it do
      expect(pdf).to receive(:bounding_box).with(position, width: width).and_yield
      expect(pdf).to receive(:pad).and_yield
      expect(pdf).to receive(:indent).and_yield
      expect(pdf).to receive(:stroke_bounds)

      subject
    end
  end

  context '.pdf_setup' do
    subject { described_class.pdf_setup(pdf) { ; } }
    let(:pdf) { double('pdf', cursor: cursor, page: page) }
    let(:cursor) { 10 }
    let(:page) { double('page', margins: { left: left, right: right }, size: size) }
    let(:left) { 2 }
    let(:right) { 2 }
    let(:size) { 'A1' }

    it do
      expect(pdf).to receive(:bounding_box).with([0, cursor], width: 1679.78).and_yield
      expect(pdf).to receive(:pad).with(10).and_yield
      expect(pdf).to receive(:indent).with(10, 10).and_yield
      expect(pdf).to receive(:stroke_bounds)
      subject
    end
  end

  describe '.format_cnpj' do
    subject { described_class.format_cnpj(cnpj) }
    let(:cnpj) { '99999999999999' }
    let(:formated_cnpj) { '99.999.999/9999-99' }

    it { expect(subject).to eq(formated_cnpj) }
  end

  describe '.format_cpf' do
    subject { described_class.format_cpf(cpf) }
    let(:cpf) { '999999999999' }
    let(:formated_cpf) { '999.999.999-99' }

    it { expect(subject).to eq(formated_cpf) }
  end

  describe '.format_currency' do
    subject { described_class.format_currency(num) }
    let(:num) { '99.99' }
    let(:formated_number) { num.tr('.', ',') }

    it { expect(subject).to eq(formated_number) }
  end

  describe '.format_number' do
    let(:num) { '99.9900' }

    context 'when default precision' do
      subject { described_class.format_number(num) }
      let(:formated_num) { '99,9900' }
      it { expect(subject).to eq(formated_num) }
    end

    context 'when defined precision' do
      subject { described_class.format_number(num, prec: 2) }
      let(:formated_num) { '99,99' }
      it { expect(subject).to eq(formated_num) }
    end
  end

  describe '.page_paper_width' do
    context 'when is array' do
      subject { described_class.page_paper_width(name) }
      let(:name) { ['A1'] }
      it { expect(subject).to eq(name.first) }
    end

    context 'when not is array' do
      subject { described_class.page_paper_width(name) }
      let(:name) { 'A1' }
      let(:expectation) { PDF::Core::PageGeometry::SIZES[name].first }
      it { expect(subject).to eq(expectation) }
    end
  end

  describe '.page_content_width' do
    let(:pdf) { double('pdf', page: page) }
    let(:page) { double('page', margins: { left: left, right: right }, size: size) }
    let(:left) { 2 }
    let(:right) { 2 }
    let(:size) { 'A1' }
    let(:expectation) { described_class.page_paper_width(page.size) - left - right }
    subject { described_class.page_content_width(pdf) }

    it { expect(subject).to eq(expectation) }
  end
end
