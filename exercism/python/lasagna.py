EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2


def bake_time_remaining(elapsed_bake_time: int) -> int:
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int baking time already elapsed.
    :return: int remaining bake time derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """

    return EXPECTED_BAKE_TIME - elapsed_bake_time

def preparation_time_in_minutes(layers: int) -> int:
    """Calculate the preparation time.

    :param layers: int number of layers.
    :return: int preparation time derived from 'PREPARATION_TIME'.

    Function that takes the number of layers as
    an argument and returns how many minutes it will take to prepare it
    based on the `PREPARATION_TIME`.
    """
    return layers * PREPARATION_TIME

def elapsed_time_in_minutes(layers: int, bake_time: int) -> int:
    """Calculate the elapsed bake time time.

    :param layers: int number of layers.
    :param bake_time: int time spent baking.
    :return: int time spent cooking.

    Function that takes the number of layers and elapsed bake time
    as an argument and returns how many minutes it took to prepare it.
    """
    return bake_time + preparation_time_in_minutes(layers)
