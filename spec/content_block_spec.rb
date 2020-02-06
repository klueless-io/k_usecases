# frozen_string_literal: true

RSpec.describe KUsecases::ContentBlock do
  subject { KUsecases::ContentBlock.parse(example) }

  let(:content1) { { label: 'label 1', description: 'description 1'} }
  let(:content2) { { label: 'label 2', description: 'description 2'} }
  let(:content_no_description) { { label: 'label'} }
  let(:content_no_label) { { description: 'description'} }
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
          have_attributes(label: 'label 1', description: 'description 1'),
          have_attributes(label: 'label 2', description: 'description 2')
        ])
      end

      it 'has valid hash' do
        expect(subject.first.to_h).to eq(label: 'label 1', description: 'description 1')
      end
    end
    context 'with missing description' do
      let(:example) do
        double(metadata: { content: [content_no_description] })
      end

      it 'has correct count' do
        expect(subject.length).to eq(1)
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(label: 'label', description: '')
        ])
      end
    end
    context 'with missing label' do
      let(:example) do
        double(metadata: { content: [content_no_label] })
      end

      it 'has correct count' do
        expect(subject.length).to eq(1)
      end

      it 'has correct content' do
        expect(subject).to match_array([
          have_attributes(label: '', description: 'description')
        ])
      end
    end
    context 'with missing label and description' do
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
