=begin

PORO to encapsulate a note file:

    NotePlan::NotePlan.new(filename).contents

=end
module NotePlan
  class NoteFile
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def contents
      @contents ||= File.read(filename)
    end
  end
end
