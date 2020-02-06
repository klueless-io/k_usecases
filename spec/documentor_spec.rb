# frozen_string_literal: true

RSpec.describe Array, :usecases, :print do
  describe 'load' do
    subject { described_class.load() }

    usecase 'Default title',
            usage: "#{described_class.name}.load" do
      fit 'AAAAAA' do
        puts @document
      end

      it 'BBBBBB' do
        # puts @document
      end
    end

    usecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root:' do
      it 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' do
        # puts @document
      end
    end

    describe 'what is this this' do
    end

    context 'and this' do
    end
  end

  describe 'more stuff' do
  end
end
