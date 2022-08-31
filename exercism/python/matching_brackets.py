import queue

def is_paired(input_string):
    brackets = queue.LifoQueue()
    for c in input_string:
        print(c)
        if c in ['[', '{', '(']:
            brackets.put(c)
            continue
        else:
            try:
                if c == ']':
                    if brackets.get_nowait() != '[':
                        return False
                    continue
                elif c == '}':
                    if brackets.get_nowait() != '{':
                        return False
                    continue
                elif c == ')':
                    if brackets.get_nowait() != '(':
                        return False
                    continue
            except queue.Empty:
                return False
    return brackets.empty()
