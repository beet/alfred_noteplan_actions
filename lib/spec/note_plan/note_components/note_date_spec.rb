require "spec_helper"

RSpec.describe NotePlan::NoteComponents::NoteDate do
  let(:filename) { "20190822.txt" }

  subject(:note_date) { NotePlan::NoteComponents::NoteDate.new(filename) }

  context "#date" do
    let(:year) { 2019 }
    let(:month) { 8 }
    let(:day) { 22 }
    let(:date) { double(Date) }

    before do
      allow(Date).to receive(:new).with(year, month, day).and_return(date)
    end

    it 'constructs a date from the year, month, and day' do
      expect(note_date.date).to eq(date)
    end
  end

  context "#year" do
    it 'extracts the year from the filename' do
      expect(note_date.year).to eq(2019)
    end
  end

  context "#month" do
    it 'extracts the month from the filename' do
      expect(note_date.month).to eq(8)
    end
  end

  context "#day" do
    it 'extracts the day from the filename' do
      expect(note_date.day).to eq(22)
    end
  end

  context "#date_formatted" do
    let(:date) { Date.today }

    before do
      allow(note_date).to receive(:date).and_return(date)
    end

    it 'is the date in YYYY-MM-DD format' do
      expect(note_date.date_formatted).to eq(date.strftime("%Y-%m-%d"))
    end
  end
end
