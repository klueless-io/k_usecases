# frozen_string_literal: true

RSpec.describe KUsecases::ContentBlock do
  subject { described_class.parse(example) }

  let(:content1) { { title: 'title 1', description: 'description 1', type: :code, code_type: :ruby} }
  let(:content2) { { title: 'title 2', description: 'description 2'} }
  let(:content_no_description) { { title: 'title'} }
  let(:content_no_title) { { description: 'description'} }
  let(:content_no_data) { {} }
  let(:content_nil) { nil }

  describe 'parse' do
    context 'with two valid contents' do
      let(:example) do
        double(metadata: { content: [content1, content2] })
      end

      it 'has correct count' do
        expect(subject.length).to eq(2)
      end

      it 'has correct  content' do
        expect(subject).to match_array([
          have_attributes(title: 'title 1', description: 'description 1', type: :code, code_type: :ruby),
          have_attributes(title: 'title 2', description: 'description 2', type: :text, code_type: '')
        ])
      end

      it 'has valid hash' do
        expect(subject.first.to_h).to eq(title: 'title 1', description: 'description 1', type: :code, code_type: :ruby)
      end
    end
    context 'with missing type' do
      let(:example) do
        double(metadata: { content: [content2] })
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(type: :text)
        ])
      end
    end
    context 'with missing code_type' do
      let(:example) do
        double(metadata: { content: [content2] })
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(code_type: '')
        ])
      end
    end
    context 'with missing description' do
      let(:example) do
        double(metadata: { content: [content_no_description] })
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(title: 'title', description: '')
        ])
      end
    end
    context 'with missing title' do
      let(:example) do
        double(metadata: { content: [content_no_title] })
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(title: '', description: 'description')
        ])
      end
    end
    context 'with missing title and description' do
      let(:example) do
        double(metadata: { content: [content_no_data] })
      end

      it 'has no content' do
        expect(subject).to be_empty
      end
    end
    context 'with nil data' do
      let(:example) do
        double(metadata: { content: [content_nil] })
      end

      it 'has no content' do
        expect(subject).to be_empty
      end
    end
  end
end
