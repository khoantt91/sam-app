class Pair<F, L> {
  F first;
  L last;

  Pair(this.first, this.last);
}

extension PairExtension<F, L> on Pair<F, L> {
  void replaceAll(Pair<F, L> newPair) {
    this.first = newPair.first;
    this.last = newPair.last;
  }
}
