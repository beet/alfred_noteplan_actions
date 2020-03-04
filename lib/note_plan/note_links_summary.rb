module NotePlan
  class NoteLinksSummary < Base
    # require 'ruby-graphviz'

    def process
      for_each_note do |note_file|

        next unless note_file.has_note_links?

        next if note_file.heading.include?("Journal Summary")

        note_file_node = graph.add_nodes(note_file.heading)

        note_file.note_links.each do |link_heading|
          link_node = graph.add_nodes(link_heading)

          graph.add_edges(note_file_node, link_node)
        end
      end

      # Can give it a :path to write to ~/Desktop?
      graph.output(png: "note_plan_links_summary.png")
    end

    private

    def graph
      @graph ||= GraphViz.new( :G, :type => :digraph, rankdir: "LR" )
    end
  end
end
