#include "list_ops.h"
#include <string.h>

list_t *new_list(size_t length, list_element_t elements[]) {
  list_t *l =
      (list_t *)malloc(sizeof(list_t) + sizeof(list_element_t) * length);
  l->length = length;
  memcpy(l->elements, elements, length * sizeof(list_element_t));
  return l;
}

list_t *append_list(list_t *list1, list_t *list2) {
  list_t *l = malloc((list1->length + list2->length) * sizeof(list_element_t) +
                     sizeof(list_t));
  l->length = list1->length + list2->length;
  memcpy(l->elements, list1->elements, list1->length * sizeof(list_element_t));
  memcpy(l->elements + list1->length, list2->elements,
         list2->length * sizeof(list_element_t));
  return l;
}

void delete_list(list_t *list) { free(list); }

size_t length_list(list_t *list) { return list->length; }

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
  list_element_t *filtered =
      (list_element_t *)malloc(sizeof(list_element_t) * list->length);
  size_t j = 0;
  for (size_t i = 0; i < list->length; i++) {
    if (filter(list->elements[i]))
      filtered[j++] = list->elements[i];
  }
  list_t *l = new_list(j, filtered);
  free(filtered);
  return l;
}

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
  list_element_t *mapped =
      (list_element_t *)malloc(sizeof(list_element_t) * list->length);
  for (size_t i = 0; i < list->length; i++)
    mapped[i] = map(list->elements[i]);
  list_t *l = new_list(list->length, mapped);
  free(mapped);
  return l;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {
  list_element_t acc = initial;
  for (size_t i = 0; i < list->length; i++)
    acc = foldl(list->elements[i], acc);
  return acc;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
  list_element_t acc = initial;
  for (int i = list->length-1; i >= 0; i--)
    acc = foldr(list->elements[i], acc);
  return acc;
}

list_t* reverse_list(list_t* list) {
  list_element_t *reversed = (list_element_t*)malloc(sizeof(list_element_t)*list->length);
  for (size_t i = 0; i < list->length; i++)
    reversed[list->length-i-1] = list->elements[i];
  list_t *l = new_list(list->length, reversed);
  free(reversed);
  return l;
}
