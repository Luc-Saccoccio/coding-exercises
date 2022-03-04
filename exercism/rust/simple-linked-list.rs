use std::iter::FromIterator;

pub struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
}

pub struct SimpleLinkedList<T> {
    head: Option<Box<Node<T>>>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        SimpleLinkedList { head: None }
    }

    pub fn is_empty(&self) -> bool {
        match &self.head {
            None => true,
            _ => false,
        }
    }

    pub fn len(&self) -> usize {
        let mut count = 0;
        let mut next = &self.head;

        while let Some(x) = next {
            count += 1;
            next = &x.next;
        }
        count
    }

    pub fn push(&mut self, _element: T) {
        self.head = Some(Box::new(Node {
            data: _element,
            next: self.head.take(),
        }))
    }

    pub fn pop(&mut self) -> Option<T> {
        match self.head.take() {
            None => None,
            Some(x) => {
                self.head = x.next;
                Some(x.data)
            },
        }
    }

    pub fn peek(&self) -> Option<&T> {
        match &self.head {
            None => None,
            Some(x) => Some(&x.data),
        }
    }

    #[must_use]
    pub fn rev(self) -> SimpleLinkedList<T> {
        let mut new = SimpleLinkedList::new();
        let mut next = self.head;

        while let Some(x) = next {
            new.push(x.data);
            next = x.next;
        }
        new
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(_iter: I) -> Self {
        let mut new = SimpleLinkedList::new();
        for i in _iter {
            new.push(i)
        }
        new
    }
}

impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut _linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut list = Vec::<T>::new();
        let mut next = _linked_list.head;

        while let Some(x) = next {
            list.insert(0, x.data);
            next = x.next;
        }

        list
    }
}
