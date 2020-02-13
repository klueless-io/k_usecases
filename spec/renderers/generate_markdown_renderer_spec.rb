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

    context 'no prettier flag' do
      it { is_expected.to have_attributes(prettier: false) }
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

    context 'write to file' do
      
      let(:documentor_settings) { {
        usecases: true,
        markdown: true,
        markdown_file: "docs/samples/sample.md" } }

      it 'should write content to file' do
        subject
        expect(File.exist?(renderer.file)).to eq(true)
        # puts renderer.file
        # system("code #{renderer.file}")
      end

      it 'should have raw content' do
        subject
        expect(File.foreach(renderer.file).take(7)).to eq(["\n", 
                                                   "## A B C Default Title\n",
                                                   "\n",
                                                   "## My custom title\n",
                                                   "\n",
                                                   "### MyClass.load\n",
                                                   "My custom usage description\n"] )
      end
    end

    context 'write to file and make prettier' do
      
      let(:documentor_settings) { {
        usecases: true,
        markdown: true,
        markdown_prettier: true,
        markdown_file: "docs/samples/sample-pretty.md" } }

      it 'prettier flag' do
        expect(renderer).to have_attributes(prettier: true)
      end

      it 'should have pretty content' do
        subject
        # system("code #{renderer.file}")

        expect(File.foreach(renderer.file).take(7)).to eq(["## A B C Default Title\n",
                                                           "\n",
                                                           "## My custom title\n",
                                                           "\n",
                                                           "### MyClass.load\n",
                                                           "\n",
                                                           "My custom usage description\n"] )
      end
    end

    context 'write to file and open in vscode' do
      
      let(:documentor_settings) { {
        usecases: true,
        markdown: true,
        markdown_file: "docs/samples/pretty.md",
        markdown_open: true } }

      it 'open flag' do
        expect(renderer).to have_attributes(open: true)
      end

      # it 'should open file in vscode' do
      #   subject
      # end
    end
  end
end
