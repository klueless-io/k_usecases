# frozen_string_literal: true

require "tempfile"

RSpec.describe KUsecases::Renderers::GenerateMarkdownRenderer do

  let(:renderer) { described_class.new(create_example_group.metadata) }
  let(:documentor) { KUsecases::Documentor.new(example_group) }

  let(:documentor_settings) { { usecases: true, markdown: true } }
  let(:decendant_children) { [describe, usecase1, usecase2, usecase3] }

  let(:example_group) { create_example_group }
  let(:descendant_parents) { create_descendant_parents }
  let(:describe) { create_describe }
  let(:usecase1) { create_usecase1 }
  let(:usecase2) { create_usecase2 }
  let(:usecase3) { create_usecase3 }
  let(:content1) { create_content1 }
  let(:content2) { create_content2 }


  describe 'initialize' do
    subject { renderer }

    context 'no markdown file' do
      it { is_expected.to have_attributes(file: 'generate_markdown.md') }
    end

    context 'with markdown file' do
      let(:documentor_settings) { {
        usecases: true,
        markdown: true,
        markdown_file: 'somefile.md' } }

      it { is_expected.to have_attributes(file: 'somefile.md') }
    end
  end

  describe 'render' do
    subject { renderer.render(documentor) }

    it 'should print some content' do
      subject
    end

    context 'write to file' do
      let(:documentor_settings) { {
        usecases: true,
        markdown: true,
        markdown_file: "#{Tempfile.new.path}.md" } }

      it 'should write content to file' do
        subject
        puts renderer.file
        system("code #{renderer.file}")
      end
    end
  end
end
