use Set;

config const testIters = 8;

record testRecord {
  var dummy: int = 0;
  proc init(dummy: int=0) { this.dummy = dummy; }
}

operator :(x: int, type t: testRecord) {
  return new testRecord(x);
}

proc doTest(type eltType) {
  var s1: set(eltType);
  var s2: set(eltType);
  var s3: set(eltType);

  assert(s1.size == 0);
  assert(s2.size == 0);
  assert(s3.size == 0);

  for i in 1..testIters {
    var x = i:eltType;
    s1.add(x);
  }

  for i in 1..(testIters * 2) {
    var x = i:eltType;
    s2.add(x);
  }

  assert(s1.size == testIters);
  assert(s2.size == (testIters * 2));

  s3 = s1 ^ s2;
  var s4 = s2 ^ s1;

  assert(s3.size == s1.size);
  assert(s1.size == testIters);
  assert(s2.size == (testIters * 2));
  assert(s4 == s3);

  for x in s3 do
    assert(!s1.contains(x) && s2.contains(x));

  s1 ^= s2;
  assert(s1 == s3);
}

doTest(int);
doTest(testRecord);
