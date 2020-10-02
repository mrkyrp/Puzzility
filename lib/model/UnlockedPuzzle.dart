class UnlockedPuzzle {
  int puzzleNo;
  int stars;
  List<bool> unlockedHints;
  bool isCompleted;

  UnlockedPuzzle(this.puzzleNo, {this.stars = 0, this.isCompleted = false});
}
