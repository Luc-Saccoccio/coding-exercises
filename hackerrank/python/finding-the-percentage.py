if __name__ == '__main__':
    student_marks = {}
    for i in range(int(input())):
        line = input().split()
        name, scores = line[0], line[1:]
        scores = list(map(float, scores))
        student_marks[name] = scores
    query_name = input()
    query_scores = student_marks[query_name]
    print("{0:.2f}".format(sum(query_scores)/(len(query_scores))))
