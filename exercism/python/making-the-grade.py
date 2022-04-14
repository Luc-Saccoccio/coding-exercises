def round_scores(student_scores):
    """"Round all provided student scores.

    :param student_scores: list of student exam scores as float or int.
    :return: list of student scores *rounded* to nearest integer value.
    """

    return [round(x) for x in student_scores]

def count_failed_students(student_scores):
    """Count the number of failing students out of the group provided.

    :param student_scores: list of integer student scores.
    :return: integer count of student scores at or below 40.
    """

    res = 0
    for score in student_scores:
        if score <= 40:
            res += 1
    return res


def above_threshold(student_scores, threshold):
    """Determine how many of the provided student scores were 'the best' based on the provided threshold.

    :param student_scores: list of integer scores
    :param threshold :  integer
    :return: list of integer scores that are at or above the "best" threshold.
    """

    res = []
    for score in student_scores:
        if score >= threshold:
            res.append(score)
    return res


def letter_grades(highest):
    """Create a list of grade thresholds based on the provided highest grade.

    :param highest: integer of highest exam score.
    :return: list of integer lower threshold scores for each D-A letter grade interval.
             For example, where the highest score is 100, and failing is <= 40,
             The result would be [41, 56, 71, 86]:

             41 <= "D" <= 55
             56 <= "C" <= 70
             71 <= "B" <= 85
             86 <= "A" <= 100
    """

    delta = round((highest - 40)/4)
    return [41 + i*delta for i in range(4)]


def student_ranking(student_scores, student_names):
    """Organize the student's rank, name, and grade information in ascending order.

     :param student_scores: list of scores in descending order.
     :param student_names: list of names in descending order by exam score.
     :return: list of strings in format ["<rank>. <student name>: <score>"].
     """

    res = []
    for i, (s, n) in enumerate(zip(student_scores, student_names)):
        res.append(f"{i+1}. {n}: {s}")
    return res


def perfect_score(student_info):
    """Create a list that contains the name and grade of the first student to make a perfect score on the exam.

    :param student_info: list of [<student name>, <score>] lists
    :return: first `[<student name>, 100]` or `[]` if no student score of 100 is found.
    """

    for s in student_info:
        if s[1] == 100:
            return s
    return []
