# frozen_string_literal: true

RSpec.describe 'KUsecases::Helpers.uc_block_content' do
  include KUsecases::Helpers

  let(:description) { 'returns a hash with environment values' }
  let(:content_type) { 'outcome' }

  expect1 = <<~TEXT.strip
                    is_expected.to eq('DOTENV' => 'true')
                    is_expected.to eq('BOB' => 'false')
                  TEXT

  expect2 = <<~TEXT.strip
                    is_expected.to eq('DOTENV' => 'true')
                  TEXT

  expect3 = <<~TEXT.strip
                    is_expected.to eq('BOB the builder' => 'false')
                  TEXT

  let(:text) {
    <<~RUBY.strip
      usecase 'Basic app configuration load' do
        outcome 'returns a hash with environment values',
                summary: 'some summary'
        do
          is_expected.to eq('DOTENV' => 'true')
          is_expected.to eq('BOB' => 'false')
        end

        outcome 'my other outcome' do
          is_expected.to eq('DOTENV' => 'true')
        end

        code 'my code' do
          is_expected.to eq('BOB the builder' => 'false')
        end

        # some commented code here
      end
    RUBY
  }

  shared_examples "find inner content block" do |expected|
    it 'has the correct body' do
      body = grab_lines(subject[:body])

      expect(body).to eq(grab_lines(expected))
    end
  end

  describe 'uc_block_content_match_top' do

    subject { uc_block_content_match_top(text, content_type, description) }

    # it 'prints' do
    #   go_print
    # end

    context 'content type == "outcome"' do
      it 'has indentation at the begining of block' do
        expect(subject[:indent]).to eq('  ')
      end

      it 'has code block named outcome' do
        expect(subject[:content_type]).to eq(content_type)
      end

      it 'finds code bloc with correct description' do
        expect(subject.to_s).to include(description)
      end
    end

    context 'content type == "code"' do
      let(:description) { 'my code' }
      let(:content_type) { 'code' }

      it 'has code block named my code' do
        expect(subject[:content_type]).to eq(content_type)
      end

      it 'finds code bloc with correct description' do
        expect(subject.to_s).to include(description)
      end
    end
  end

  describe 'uc_block_content_match_top_body_bottom' do

    subject { uc_block_content_match_top_body_bottom(text, content_type, description, indent) }

    let(:indent) { '  ' }

    # it 'prints' do
    #   go_print
    # end

    context 'outcome 1' do
      it_behaves_like "find inner content block", expect1
    end

    context 'outcome 2' do
      let(:description) { 'my other outcome' }

      it_behaves_like "find inner content block", expect2
    end

    context 'code 1' do
      let(:description) { 'my code' }
      let(:content_type) { 'code' }

      it_behaves_like "find inner content block", expect3
    end
  end

  describe 'uc_block_content' do

    subject { grab_lines(uc_block_content(text, description)) }

    # it 'prints' do
    #   go_print
    # end

    context 'outcome 1' do
      it { is_expected.to eq(grab_lines(expect1)) }
    end

    context 'outcome 2' do
      let(:description) { 'my other outcome' }

      it { is_expected.to eq(grab_lines(expect2)) }
    end

    context 'code 1' do
      let(:description) { 'my code' }
      let(:content_type) { 'code' }

      it { is_expected.to eq(grab_lines(expect3)) }
    end
  end

  def grab_lines(text)
    text.split("\n").compact.collect(&:strip).reject(&:empty?)
  end

  def go_print
    puts '-' * 70
    puts subject
    puts '-' * 70

    puts 'description: ' + description
    puts 'content_type: ' + content_type
  end
end
