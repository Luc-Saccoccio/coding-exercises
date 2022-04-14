class Queen:
    def __init__(self, row, column):
        if row < 0:
            raise ValueError("row not positive")
        if row > 7:
            raise ValueError("row not on board")
        if column < 0:
            raise ValueError("column not positive")
        if column > 7:
            raise ValueError("column not on board")
        self.row = row
        self.column = column

    def can_attack(self, another_queen):
        r = self.row == another_queen.row
        c = self.column == another_queen.column
        if r and c:
            raise ValueError("Invalid queen position: both queens in the same square")
        return abs(self.column - another_queen.column) == abs(self.row - another_queen.row) or r or c
