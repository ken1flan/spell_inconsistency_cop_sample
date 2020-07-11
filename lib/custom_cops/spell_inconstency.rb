# frozen_string_literal: true

require 'yaml'

module CustomCops
  class SpellInconstency < RuboCop::Cop::Cop
    MESSAGE_TEMPLATE = "Use '%s' instead of '%s'."
    SPELL_INCONSTENCIES = YAML.load_file(Pathname(__dir__).join('spell_inconstency.yml'))

    ASTS_SINGLE = %I[str const sym casgn arg kwarg].freeze
    ASTS_SINGLE.each do |ast|
      define_method "on_#{ast}" do |node|
        SPELL_INCONSTENCIES.each do |wrong_keyword, correct_keyword|
          add_offense(node, message: message(wrong_keyword, correct_keyword)) if node.source.include?(wrong_keyword)
        end
      end
    end

    ASTS_FIRST_CHILD = %I[lvasgn def].freeze
    ASTS_FIRST_CHILD.each do |ast|
      define_method "on_#{ast}" do |node|
        target = node.children.first
        SPELL_INCONSTENCIES.each do |wrong_keyword, correct_keyword|
          add_offense(node, message: message(wrong_keyword, correct_keyword)) if target.match?(/#{wrong_keyword}/)
        end
      end
    end

    private

    def message(wrong_keyword, correct_keyword)
      MESSAGE_TEMPLATE % [correct_keyword, wrong_keyword]
    end
  end
end
