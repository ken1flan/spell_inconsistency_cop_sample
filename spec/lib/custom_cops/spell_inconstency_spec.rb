# frozen_string_literal: true

# require 'rails_helper'

RSpec.describe CustomCops::SpellInconstency do
  describe '' do
    subject(:cop) { described_class.new }

    it '変数名のtypoを検知できること' do
      expect_offense(<<-RUBY)
        fanclub = 'fan_club'
        ^^^^^^^^^^^^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it '定数名のtypoを検知できること' do
      expect_offense(<<-RUBY)
        FANCLUB = 'fan_club'
        ^^^^^^^^^^^^^^^^^^^^ Use 'FAN_CLUB' instead of 'FANCLUB'.
      RUBY
    end

    it '文字列のtypoを検知できること' do
      expect_offense(<<-RUBY)
        fan_club = 'fanclub'
                   ^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'シンボルのtypoを検知できること' do
      expect_offense(<<-RUBY)
        fan_club = :fanclub
                   ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義のメソッド名のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def set_fanclub(arg)
        ^^^^^^^^^^^^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
          a = 1
        end
      RUBY
    end

    it 'メソッド定義の引数のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(fanclub); a = 1; end
                      ^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義の引数の文字列のデフォルト値のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(a = 'fanclub'); a = 1; end
                          ^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義の引数のシンボルのデフォルト値のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(a = :fanclub); a = 1; end
                          ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義のキーワード引数のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(fanclub:); a = 1; end
                      ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義のキーワード引数の文字列のデフォルト値のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(a: 'fanclub'); a = 1; end
                         ^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end

    it 'メソッド定義のキーワード引数のシンボルのデフォルト値のtypoを検知できること' do
      expect_offense(<<-RUBY)
        def some_func(a: :fanclub); a = 1; end
                         ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
      RUBY
    end
  end
end
