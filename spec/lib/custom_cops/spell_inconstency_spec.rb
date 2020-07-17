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
end
