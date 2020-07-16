# frozen_string_literal: true

require 'yaml'

module CustomCops
  class SpellInconsistency < RuboCop::Cop::Cop
    MESSAGE_TEMPLATE = "Use '%s' instead of '%s'."
    SPELL_INCONSISTENCIES = YAML.load_file(Pathname(__dir__).join('spell_inconsistency.yml'))

    NODE_TYPES = %I[str const sym].freeze
    NODE_TYPES.each do |node_type|
      define_method "on_#{node_type}" do |node|
        SPELL_INCONSISTENCIES.each do |wrong_keyword, correct_keyword|
          add_offense(node, message: message(wrong_keyword, correct_keyword)) if node.source.include?(wrong_keyword)
        end
      end
    end

    def on_lvasgn(node)
      target = node.children.first
      SPELL_INCONSISTENCIES.each do |wrong_keyword, correct_keyword|
        add_offense(node, message: message(wrong_keyword, correct_keyword)) if target.match?(/#{wrong_keyword}/)
      end
    end

    def message(wrong_keyword, correct_keyword)
      MESSAGE_TEMPLATE % [correct_keyword, wrong_keyword]
    end
  end
end
