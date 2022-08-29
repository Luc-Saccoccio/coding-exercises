#include "robot_simulator.h"

robot_status_t robot_create(robot_direction_t direction, int x, int y) {
  robot_status_t r = { direction, {x, y} };
  return r;
}

static void turn_left(robot_status_t *robot) {
  robot->direction = ((robot->direction - 1) + DIRECTION_MAX) % DIRECTION_MAX;
}

static void turn_right(robot_status_t *robot) {
  robot->direction = (robot->direction + 1) % DIRECTION_MAX;
}

static void move(robot_status_t *robot) {
  switch (robot->direction) {
    case DIRECTION_NORTH:
      robot->position.y++;
      break;
    case DIRECTION_EAST:
      robot->position.x++;
      break;
    case DIRECTION_WEST:
      robot->position.x--;
      break;
    case DIRECTION_SOUTH:
      robot->position.y--;
    default:
      break;
  }
}

void robot_move(robot_status_t *robot, const char *commands) {
  while (*commands != 0) {
    switch (*commands) {
      case 'L':
        turn_left(robot);
        break;
      case 'R':
        turn_right(robot);
        break;
      case 'A':
        move(robot);
      default:
        break;
    }
    commands++;
  }
}
