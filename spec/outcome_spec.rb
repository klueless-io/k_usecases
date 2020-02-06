# frozen_string_literal: true

RSpec.describe KUsecases::Outcome do
  subject { KUsecases::Outcome.parse(example) }

  let(:example_empty) { double(description: '') }

  describe 'parse' do
    context 'valid outcome' do
      let(:example) { double(description: 'test example') }

      it { is_expected.to have_attributes(description: 'test example') }

      it 'valid hash' do
        expect(subject.to_h).to eq(description: 'test example')
      end
    end

    context 'description not supplied' do
      let(:example) { double(description: nil) }

      it { is_expected.to be_nil }
    end

    context 'description is blank' do
      let(:example) { double(description: nil) }

      it { is_expected.to be_nil }
    end
  end
end
