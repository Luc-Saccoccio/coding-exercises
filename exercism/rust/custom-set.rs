use std::collections::BTreeSet;

#[derive(Debug, PartialEq, Eq)]
pub struct CustomSet<T> {
    set: BTreeSet<T>,
}

impl<T: Ord + Clone> CustomSet<T> {
    pub fn new(input: &[T]) -> Self {
        let mut set = BTreeSet::new();
        for elem in input.iter().cloned() {
            set.insert(elem);
        }
        Self { set }
    }

    pub fn contains(&self, elem: &T) -> bool {
        self.set.contains(elem)
    }

    pub fn add(&mut self, elem: T) {
        self.set.insert(elem);
    }

    pub fn is_subset(&self, other: &Self) -> bool {
        self.set.is_subset(&other.set)
    }

    pub fn is_empty(&self) -> bool {
        self.set.is_empty()
    }

    pub fn is_disjoint(&self, other: &Self) -> bool {
        self.set.is_disjoint(&other.set)
    }

    #[must_use]
    pub fn intersection(&self, other: &Self) -> Self {
        Self { set: self.set.intersection(&other.set).cloned().collect() }
    }

    #[must_use]
    pub fn difference(&self, other: &Self) -> Self {
        Self { set: self.set.difference(&other.set).cloned().collect() }
    }

    #[must_use]
    pub fn union(&self, other: &Self) -> Self {
        Self { set: self.set.union(&other.set).cloned().collect() }
    }
}
