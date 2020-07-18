RSpec.describe CustomCops::SpellInconsistency do
  subject(:cop) { described_class.new }

  it '文字列のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      fan_club = 'fanclub'
                 ^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'シンボルのまちがいを検知できること' do
    expect_offense(<<-RUBY)
      fan_club = :fanclub
                 ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it '定数のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      fan_club = FANCLUB
                 ^^^^^^^ Use 'FAN_CLUB' instead of 'FANCLUB'.
    RUBY
  end

  it 'ハッシュのキー名のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      fan_club = { fanclub: 1 }
                   ^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it '変数名のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      fanclub = 'fan_club'
      ^^^^^^^^^^^^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it '定数名のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      FANCLUB = 'fan_club'
      ^^^^^^^^^^^^^^^^^^^^ Use 'FAN_CLUB' instead of 'FANCLUB'.
    RUBY
  end

  it 'メソッド名のまちがいを検知できること' do
    expect_offense(<<-RUBY)
      def set_fanclub; hoge; end
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'メソッドの引数名の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(fanclub); hoge; end
                   ^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'メソッドの引数のデフォルト値(文字列)の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(a = 'fanclub'); hoge; end
                       ^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'メソッドの引数のデフォルト値(シンボル)の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(a = :fanclub); hoge; end
                       ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'メソッドの引数のデフォルト値(定数)の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(a = FANCLUB); hoge; end
                       ^^^^^^^ Use 'FAN_CLUB' instead of 'FANCLUB'.
    RUBY
  end

  it 'メソッドのキーワード引数の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(fanclub:); hoge; end
                   ^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'メソッドのキーワードオプション引数の間違いを検知できること' do
    expect_offense(<<-RUBY)
      def set_func(fanclub: 'a'); hoge; end
                   ^^^^^^^^^^^^ Use 'fan_club' instead of 'fanclub'.
    RUBY
  end

  it 'クラス名の間違いを検知できること' do
    expect_offense(<<-RUBY)
      class Fanclub; end
            ^^^^^^^ Use 'FanClub' instead of 'Fanclub'.
    RUBY
  end

  it 'モジュール名の間違いを検知できること' do
    expect_offense(<<-RUBY)
      module Fanclub; end
             ^^^^^^^ Use 'FanClub' instead of 'Fanclub'.
    RUBY
  end
end
