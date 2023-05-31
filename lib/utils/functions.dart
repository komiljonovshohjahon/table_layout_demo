List<T> swapList<T>(List<T> list, int from, int to) {
  final List<T> l = [...list];
  T temp = l[from];
  l[from] = l[to];
  l[to] = temp;
  return l;
}
