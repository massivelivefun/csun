class Or:
    def __init__(self, left, right):
        self.left = left
        self.right = right

    def __str__(self):
        return "or({}, {})". format(str(self.left), str(self.right))


class And:
    def __init__(self, left, right):
        self.left = left
        self.right = right

    def __str__(self):
        return "and({}, {})".format(str(self.left), str(self.right))


def gen(depth):
    yield True
    yield False
    if depth > 0:
        for left in gen(depth - 1):
            for right in gen(depth - 1):
                yield Or(left, right)
                yield And(left, right)
