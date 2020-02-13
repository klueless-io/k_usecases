# frozen_string_literal: true

RSpec.describe KUsecases::Content do
  subject { described_class.parse(example) }

  describe 'parse' do
    context 'with data does not represent valid content' do
      context 'when description nil' do
        let(:example) { double(description: nil) }

        it { is_expected.to be_nil }
      end

      context 'when description empty' do
        let(:example) { double(description: '') }

        it { is_expected.to be_nil }
      end

      context 'when content type is missing' do
        let(:example) { double(description: 'david', metadata: { }) }

        it { is_expected.to be_nil }
      end

      context 'when content type is invalid' do
        let(:example) { double(description: 'david', metadata: { content_type: :invalid }) }

        it { is_expected.to be_nil }
      end
    end

    context 'with data for valid content' do

      context 'when blank description is overwritten by rspec' do
        let(:example) { double(description: 'example at ./spec/', metadata: { content_type: :outcome }) }

        it { is_expected.to be_a (KUsecases::ContentOutcome)}
        it { is_expected.to have_attributes(title: '') }
      end

      context 'when content_type: :outcome' do
        # NOTE: What rspec calls a description, I call a title
        #       rspec.description maps to content.title 
        let(:example) { double(description: 'david', metadata: { content_type: :outcome }) }

        it { is_expected.to be_a (KUsecases::ContentOutcome)}
        it { is_expected.to have_attributes(title: 'david',
                                            summary: '',
                                            type: 'outcome'
                                           ) }
      end

      context 'when content_type: :outcome with description' do
        let(:example) { double(description: 'david', metadata: { content_type: :outcome, summary: 'my summary' }) }

        it { is_expected.to be_a (KUsecases::ContentOutcome)}
        it { is_expected.to have_attributes(title: 'david',
                                            summary: 'my summary',
                                            type: 'outcome'
                                          ) }
      end

      context 'when content_type: :outcome' do
        let(:example) { double(description: 'david', metadata: { content_type: :code, code: 'some code', code_type: 'ruby' }) }

        it { is_expected.to be_a (KUsecases::ContentCode)}
        it { is_expected.to have_attributes(title: 'david',
                                            type: 'code',
                                            code: 'some code',
                                            code_type: 'ruby'
                                          ) }
      end
    end
  end
end
