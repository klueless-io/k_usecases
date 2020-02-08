# frozen_string_literal: true

RSpec.describe KUsecases::Renderers::PrintJsonRenderer do

  let(:documentor) { KUsecases::Documentor.new(example_group) }

  describe 'initialize' do
    subject { described_class.new(create_example_group.metadata) }
  end

  describe 'render' do
    subject { described_class.new(create_example_group.metadata).render(documentor) }

    let(:documentor_settings) { {
      document_title: 'Title',
      document_description: 'Description',
      usecases: true,
      json: true } }

    let(:decendant_children) { [describe, usecase1, usecase2, usecase3] }

    let(:example_group) { create_example_group }
    let(:descendant_parents) { create_descendant_parents }
    let(:describe) { create_describe }
    let(:usecase1) { create_usecase1 }
    let(:usecase2) { create_usecase2 }
    let(:usecase3) { create_usecase3 }
    let(:content1) { create_content1 }
    let(:content2) { create_content2 }

    it 'should print some content' do
      subject
    end
  end
end
