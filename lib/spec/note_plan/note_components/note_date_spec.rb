require "spec_helper"

RSpec.describe NotePlan::NoteComponents::NoteDate do
  let(:filename) { "20190822.txt" }

  subject(:note_date) { NotePlan::NoteComponents::NoteDate.new(filename) }

  describe "#date_formatted" do
    context 'for daily notes' do
      let(:filename) { '20230619.md' }

      it 'is the date in YYYY-MM-DD format' do
        expect(subject.date_formatted).to eq('2023-06-19')
      end
    end

    context 'for weekly notes' do
      let(:filename) { '2023-W01.md' }

      it 'is the formatted week number' do
        expect(subject.date_formatted).to eq('Week 01')
      end
    end

    context 'for monthly notes' do
      let(:filename) { '2023-01.md' }

      it 'is the formatted month name' do
        expect(subject.date_formatted).to eq('January')
      end
    end

    context 'for yearly notes' do
      let(:filename) { '2023.md' }

      it 'is the year' do
        expect(subject.date_formatted).to eq('2023')
      end
    end
  end

  context "#date_human" do
    context 'for daily notes' do
      let(:filename) { '20230619.md' }

      it 'is the date in "Wednesday March 4 2020" format' do
        expect(note_date.date_human).to eq('Monday June 19 2023')
      end
    end

    context 'for weekly notes' do
      let(:filename) { '2023-W01.md' }

      it 'is the year' do
        expect(subject.date_human).to eq(2023)
      end
    end

    context 'for monthly notes' do
      let(:filename) { '2023-01.md' }

      it 'is the year' do
        expect(subject.date_human).to eq(2023)
      end
    end

    context 'for yearly notes' do
      let(:filename) { '2023.md' }

      it 'is "yearly"' do
        expect(subject.date_human).to eq('yearly')
      end
    end
  end
end
