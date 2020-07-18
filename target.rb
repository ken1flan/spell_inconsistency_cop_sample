a = 'Fanclub'
b = :fanclub
c = FANCLUB
fanclub = 'a'
FANCLUB = 'a'
def set_fanclub; hoge; end
def set_func(fanclub); hoge; end
def set_func(a = 'fanclub'); hoge; end
def set_func(a = :fanclub); hoge; end
def set_func(a = FANCLUB); hoge; end
def set_func(fanclub:); hoge; end
